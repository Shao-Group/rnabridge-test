plot.precision = function(datafile, texfile, t1, t2)
{
	data = read.table(datafile);
	n = length(data[,1]);
	library(tikzDevice);
	tikz(texfile, height = 2.8, width = 1.0 + 0.35 * n);
	xx = matrix(nrow = 2, ncol = n);
	xx[1,] = t(data[,14]);
	xx[2,] = t(data[,13]);
	maxvalue = max(xx[2,]) * 1.2;
	par(mar=c(0.6,3.3,1.0,0.0));
	barplot(xx, beside=TRUE, col=c(2,4), xaxt = 'n', yaxt = 'n', ylim = c(0, maxvalue));
	axis(2, tck = -0.025, mgp = c(0, 0.6, 0));
	mtext("Precision", side = 2, line =2.20);
	px = n;
	py = maxvalue;
	legend(px, py, c(t1, t2), col = c(2,4), fill = c(2,4));
	dev.off();
}

plot.correct = function(datafile, texfile, t1, t2)
{
	data = read.table(datafile);
	n = length(data[,1]);
	library(tikzDevice);
	tikz(texfile, height = 2.8, width = 1.0 + 0.35 * n);
	xx = matrix(nrow = 2, ncol = n);
	xx[1,] = t(data[,17]) * t(data[,11]) / 100;
	xx[2,] = t(data[,16]) * t(data[,11]) / 100;
	maxvalue = max(xx[2,]) * 1.2;
	par(mar=c(0.6,3.3,1.0,0.0));
	barplot(xx, beside=TRUE, col=c(2,4), xaxt = 'n', yaxt = 'n', ylim = c(0, maxvalue));
	axis(2, tck = -0.025, mgp = c(0, 0.6, 0));
	mtext("Correct", side = 2, line =2.20);
	px = n;
	py = maxvalue;
	legend(px, py, c(t1, t2), col = c(2,4), fill = c(2,4));
	dev.off();
}
