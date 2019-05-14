#!/usr/bin/env python3

"""
Created on Fri Oct 19 12:06:05 2018

@author: pdimens
"""
import os
import pandas as pd
from bokeh.plotting import figure, ColumnDataSource, show
from bokeh.models import HoverTool, Legend
from bokeh.io import save, output_file
output_file("structure_assignment.html")

stru_res = "/home/pdimens/Documents/structure_results.csv"
df = pd.read_csv(stru_res, sep="\t", header=0)
df

probs = ["Gulf of Mexico", "Atlantic Ocean"]
df.maturity.to_string()
sourcedata = ColumnDataSource(data={
    'indiv': df.indiv,
    'loc': df.locality,
    'length': df.flength,
    'Atlantic Ocean': df.statlantic,
    'Gulf of Mexico': df.stgulf,
    'sex': df.sex,
    'capmonth': df.capmonth,
    'capyear': df.capyear,
    'maturity': df.maturity
})

TOOLTIPS = [
    ("Individual", "@indiv"),
    ("Locality", "@loc"),
    ("Fork Length", "@{length}"),
    ("Sex", "@sex"),
    ("Repro Status", "@maturity"),
    ("Month Capture", "@capmonth"),
    ("Year Capture", "@capyear"),
    ("Probability Atlantic", "@{Atlantic Ocean}"),
    ("Probability Gulf", "@{Gulf of Mexico}"),
]


p = figure(
    x_range=df.indiv,
    sizing_mode='stretch_both',
    toolbar_location=None,
    tools=[]
)
rs = p.vbar_stack(
    probs,
    x='indiv',
    source=sourcedata,
    width=1, color=['#727272', '#aaaaaa'],
    hover_fill_color=None,
    hover_line_color='#FFFFFF',
)
legend = Legend(items=[(membership, [r])
                       for (membership, r) in zip(probs, rs)], location=(0, 320))

p.add_layout(legend, 'right')
p.title.text="Probability of Membership Inferred with Bayesian Clustering"
p.title.align = "center"
p.title.text_font = "sans"
p.title.text_font_size = "20px"
p.xgrid.grid_line_color = None
p.background_fill_color = None
p.y_range.start = 0
p.y_range.end = 1
p.axis.axis_line_color = None
p.yaxis.axis_label = 'Probability of Membership'
p.xaxis.visible = False
p.axis.minor_tick_line_color = None
p.yaxis.axis_label_text_font_size = '20pt'
p.yaxis.major_label_text_font_size = '14pt'
p.yaxis.axis_label_text_font = 'sans'
p.yaxis.axis_label_text_font_style = 'normal'
p.yaxis.major_label_text_font = 'sans'
p.min_border_bottom = 200
p.min_border_top = 40
p.min_border_left = 30
p.min_border_left = 30
p.add_tools(HoverTool(tooltips=TOOLTIPS,
                      mode='mouse'
                      ))

save(filename='/home/pdimens/structure_assignment.html', obj=p)
show(p)
