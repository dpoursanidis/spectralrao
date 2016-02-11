#Load the function
source("~/Desktop/scripts/spectralrao.r")

#Random simulated spectral matrix
set.seed(26)
r1<-matrix(rpois(2500,lambda=5),nrow=50,ncol=50)

#Clustered simulated spectral matrix
xy1 <- matrix(rnorm(25, 0, .25), ncol=5,nrow=5)
xy2 <- matrix(rnorm(25, -.5, .1), ncol=5,nrow=5)
xy3 <- matrix(rnorm(25, .5, .1), ncol=5,nrow=5)
xy4 <- matrix(rnorm(25, .5, .25), ncol=5,nrow=5)
r2 <- cbind(rbind(xy1, xy2),rbind(xy3,xy4))

#User simulated spectral matrix
r3<-matrix(data=c(-0.5,-0.5,-0.5,-0.5,0.8,-0.5,-0.5,-0.5,-0.5,
    0.8,0,0,0,0,0,0,0,0.8,0.8,0.8,0,0.5,0.8,0.8,0.5),nrow=5,ncol=5)

#True rasterm data
ndvi<-raster("Desktop/rao/ndvi_rao")
ndwi<-raster("Desktop/rao/ndwi_rao")

#Run the function
raomatrix<-spectralrao(r3,"euclidean",window=3)

#Comparison
par(mfrow=c(1,3))
plot(raster(r3),main="landscape (NDVI)")
plot(raster(raomatrix[[1]]),main="Rao's Q")
plot(raster(raomatrix[[2]]),main="Shannon's Index")

#Raos vs Shannon
plot(raomatrix[[1]]~raomatrix[[2]],pch=16,col="grey",cex=2,xlab="ShannonD",ylab="RaoQ")