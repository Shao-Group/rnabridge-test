hist.2 = function(datafile, texfile, p1, p2, t1, t2, title, flag)
{
	data = read.table(datafile);
	n = length(data[,1]);
	library(tikzDevice);
	tikz(texfile, width = 4.5, height = 3.5);
	xx = matrix(nrow = 2, ncol = n);
	xx[1,] = t(data[,p1]);
	xx[2,] = t(data[,p2]);
	maxvalue = ceiling(max(xx));
	minvalue = floor(min(xx));
	par(mar=c(3.0,3.0,0.0,0.0));

	h1=hist(xx[1,], breaks = seq(minvalue,maxvalue,length.out=50), plot=FALSE);
	h2=hist(xx[2,], breaks = seq(minvalue,maxvalue,length.out=50), plot=FALSE);
	max1=max(h1$counts);
	max2=max(h2$counts);
	maxy=max(max1, max2);

	hist(xx[1,], col=rgb(1,0,0,0.5), breaks = seq(minvalue,maxvalue,length.out=50), xlim = c(minvalue, maxvalue), ylim = c(0,maxy), xaxt='n', yaxt='n', xlab="", ylab="", main="");
	hist(xx[2,], col=rgb(0,0,1,0.5), breaks = seq(minvalue,maxvalue,length.out=50), add=TRUE);
	axis(1, tck = -0.025, mgp = c(0, 0.6, 0));
	axis(2, tck = -0.025, mgp = c(0, 0.6, 0));
	mtext(title, side = 1, line = 2)
	mtext("Frequency", side = 2, line = 2)
	px = minvalue;
	py = 150;
	if(flag > 0)
	{
		legend(px, py, c(t1, t2), col = c(2,4), fill = c(rgb(1,0,0,0.5),rgb(0,0,1,0.5)), bty='n', cex = 1, xjust = 0, x.intersp = 0.5);
	}
	dev.off();
}
