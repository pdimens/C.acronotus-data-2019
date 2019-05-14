library(ggplot2)

##### KEYS assignment #####

geneplot.results.assignment <- read.csv("~/Omega/TAMUCC MS/Manuscript/geneplot results assignment.csv")
assign_results<-geneplot.results.assignment
assign_results$pop = factor(assign_results$pop,levels(assign_results$pop)[c(6,3,1,2,7,4,5)])

p <- ggplot(assign_results, aes(Ln.Likelihood.of.Atlantic.Membership, Ln.Likelihood.of.Gulf.of.Mexico.Membership))
p+geom_point(aes(color=factor(pop), shape = factor(pop)), size = 4)+
  xlim(-520,-400)+
  ylim(-520,-400)+
  xlab("Log10 genotype probability for Atlantic Ocean") + ylab("Log10 genotype probability for Gulf of Mexico")+
  geom_abline(slope=1,intercept = 0)+
  coord_equal()+
  scale_shape_manual(values = c(0,1,2,8,15,16,17))+
  theme(legend.title=element_blank(),legend.key = element_blank(),axis.title=element_text(size=14),legend.justification = c(1, 0), legend.position = c(1, 0))




##### ATL v GULF #####

mig_results <- read.csv("~/Omega/TAMUCC MS/Manuscript/geneplot results atl-gulf.csv")
mig_results$pop = factor(mig_results$pop,levels(mig_results$pop)[c(5,2,1,6,3,4)])

p <- ggplot(mig_results, aes(Pop1, Pop2))
p+geom_point(aes(color=factor(pop), shape = factor(pop)), size = 4)+
  xlim(-520,-400)+
  ylim(-520,-400)+
  xlab("Log10 genotype probability for Atlantic Ocean") + ylab("Log10 genotype probability for Gulf of Mexico")+
  geom_abline(slope=1,intercept = 0)+
  coord_equal()+
  scale_shape_manual(values = c(0,1,2,15,16,17))+
  theme(legend.title=element_blank(),legend.key = element_blank(),axis.title=element_text(size=14),legend.justification = c(1, 0), legend.position = c(1, 0))
