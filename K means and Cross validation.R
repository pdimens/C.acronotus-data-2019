##### libraries #####
library(adegenet)
library(pegas)
library(hierfstat)
library(poppr)

library(extrafont)
#font_import()
#loadfonts(device="win")       #Register fonts for Windows bitmap output
fonts() 



setwd("~/MEGA/TAMUCC MS/Manuscript/input files/genepop files")
gen <- read.genepop(file = "acronotus_manuscript_nokey.gen", ncode = 3L, quiet = FALSE)
xx<-gen
gen<- xx

# gen2<-read.genepop(file = "kmeans_genepop.gen", ncode = 3L, quiet = FALSE)

num.loci <- length(locNames(gen))
ind.tab <- read.table("acronotus_manuscript_nokey.gen", skip=num.loci+2, fill=TRUE) # Read in igenepop file as table, skipping the header, the list of loci, and the first 'POP'
ind.tab <- subset(ind.tab, V1 !='POP') # Remove remaining 'POP' lines (rows) in table
inds <- ind.tab$V1 # Return the column of individual names as list of characters
inds <- gsub(',', '', inds) # Remove the trailing comma
indNames(gen) <- inds # assign new list of individual (genotype) names to genind object
PopNames <- c("CA","GA","SC","MEG","NEG","SEG")
popNames(gen) <- PopNames
pop(gen)

#### cross validation ####
set.seed(999)
par(mfrow=c(1,1))
pramx <- xvalDapc(tab(gen, NA.method="mean"), pop(gen), n.rep=100)  ## converges on 26
pramx <- xvalDapc(tab(gen, NA.method="mean"), pop(gen), n.pca=20:30, n.rep=100)


##### the good PCA #####
system.time(pramx2 <- xvalDapc(tab(gen, NA.method="mean"), pop(gen),
                              n.pca=26, n.rep=100,
                              parallel="snow", ncpus=2L))

cc<-as.matrix(pramx2$`Mean Successful Assignment by Number of PCs of PCA`)          
dd<-as.matrix(pramx2$`Root Mean Squared Error by Number of PCs of PCA`)          
mypallete <- c("#2a6189","#3392cc","#9ec6df", "#d5aaf0","#996699","#330033")
par(family = "Roboto")
scatter(pramx2$DAPC,
        cex = 2, 
        legend = 1, 
        #txt.leg=c("Cape Canaveral","Georgia","South Carolina", "Mideast Gulf","Northeast Gulf","Southeast Gulf"),
        clabel = FALSE,
        cstar = FALSE,
        posi.leg = "bottomleft", 
        scree.pca = TRUE, 
        posi.pca = "topright", 
        posi.da="bottomright",
        cleg = 0.75, 
        xax = 1, 
        yax = 2, 
        cell=0,
        solid = 0.7,
        pch= c(19,19,19,15,15,15),
        col= mypallete,
        bg="#EEEEEE"
        )

legend(x= -550, y = 50,legend = c("Cape Canaveral","Georgia","South Carolina", "Florida Keys", "Mideast Gulf","Northeast Gulf","Southeast Gulf"))

#inset.solid = 1, 
scatter(pramx$DAPC, posi.da="bottomright", bg="white", pch=c(19,19,19,18,18,18,18))

scatter(pramx2$DAPC, cex = 2, legend = TRUE, 
        clabel = FALSE, posi.leg = "bottomleft", scree.pca = TRUE, 
        posi.pca = "topleft", cleg = 0.75, xax = 1, yax = 2, inset.solid = 1)


#### find K clusters ####

setwd("~/MEGA/TAMUCC MS/Manuscript/input files")
gen <- read.genepop(file = "acronotus_manuscript_nokey.gen", ncode = 3L, quiet = FALSE)
xx<-gen
gen<- xx

num.loci <- length(locNames(gen))
ind.tab <- read.table("acronotus_manuscript_nokey.gen", skip=num.loci+2, fill=TRUE) # Read in igenepop file as table, skipping the header, the list of loci, and the first 'POP'
ind.tab <- subset(ind.tab, V1 !='POP') # Remove remaining 'POP' lines (rows) in table
inds <- ind.tab$V1 # Return the column of individual names as list of characters
inds <- gsub(',', '', inds) # Remove the trailing comma
indNames(gen) <- inds # assign new list of individual (genotype) names to genind object
PopNames <- c("CA","GA","SC","MEG","NEG","SEG")
popNames(gen) <- PopNames
pop(gen)

bic2<-find.clusters(gen, clust=NULL, n.pca=26,
              n.clust=NULL, stat=c("BIC"),
              choose.n.clust=TRUE, criterion=c("diffNgroup"),
              max.n.clust=7, n.iter=1000000,n.start=1,
              scale=FALSE, pca.select=c("nbEig"),
              perc.pca=NULL,glPca=NULL)

bic.2<-as.matrix(bic2$Kstat)
bic2$Kstat
