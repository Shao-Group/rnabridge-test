plot.horiz.3 = function(datafile, texfile, p1, p2, p3, title, flag)
{
	data = read.table(datafile);
	n = length(data[,1]);
	library(tikzDevice);
	tikz(texfile, width = 4.0, height = 0.4 + 0.4 * n);
	xx = matrix(nrow = 3, ncol = n);
	xx[1,] = t(data[,p1]);
	xx[2,] = t(data[,p2]);
	xx[3,] = t(data[,p3]);
	maxvalue1 = max(xx[1,]);
	maxvalue2 = max(xx[2,]);
	maxvalue3 = max(xx[3,]);
	maxvalue = max(maxvalue1, maxvalue2, maxvalue3) * 1.1;

	par(mar=c(0.1,4.5,3.0,0.0));
	barplot(xx, horiz=TRUE, beside=TRUE, col=c(4,2,6), xaxt = 'n', yaxt = 'n', xlim = c(0, maxvalue));
	axis(3, tck = -0.025, mgp = c(0, 0.6, 0), pos = n * 4 + 1);
	axis(3, tick = FALSE, pos = n * 4 + 3, at = c(maxvalue * 0.45), labels = c(title));
	axis(2, tick = FALSE, las = 1, at = c(1:n) * 4 - 1.5, labels = t(data[,1]), mgp = c(0, 0.3, 0));
	px = maxvalue;
	py = 7;
	if(flag > 0)
	{
		legend(px, py, c("Coral w/ ref.", "Coral w/o ref.", "w/o Coral"), col = c(6,2,4), fill = c(6,2,4), bty='n', cex = 1, xjust = 1, x.intersp = 0.5);
	}
	dev.off();
}

plot.precision.horiz = function(datafile, texfile, p1, p2, t1, t2, title, flag)
{
	data = read.table(datafile);
	n = length(data[,1]);
	library(tikzDevice);
	tikz(texfile, width = 4.0, height = 0.4 + 0.25 * n);
	xx = matrix(nrow = 2, ncol = n);
	xx[1,] = t(data[,p1]);
	xx[2,] = t(data[,p2]);
	maxvalue = max(xx[2,]) * 1.1;
	par(mar=c(0.1,4.5,3.0,0.0));
	barplot(xx, horiz=TRUE, beside=TRUE, col=c(2,4), xaxt = 'n', yaxt = 'n', xlim = c(0, maxvalue));
	axis(3, tck = -0.025, mgp = c(0, 0.6, 0), pos = n * 3 + 1);
	axis(3, tick = FALSE, pos = n * 3 + 3, at = c(maxvalue * 0.45), labels = c(title));
	axis(2, tick = FALSE, las = 1, at = c(1:n) * 3 - 1, labels = t(data[,1]), mgp = c(0, 0.3, 0));
	px = maxvalue;
	py = 5.5;
	if(flag > 0)
	{
		legend(px, py, c(t2, t1), col = c(4,2), fill = c(4,2), bty='n', cex = 1, xjust = 1, x.intersp = 0.5);
	}
	dev.off();
}

plot.correct.horiz = function(datafile, texfile, p1, p2, t1, t2, title, flag)
{
	data = read.table(datafile);
	n = length(data[,1]);
	library(tikzDevice);
	tikz(texfile, width = 4.0, height = 0.4 + 0.25 * n);
	#pdf("test.pdf", width = 4.2, height = 0.6 + 0.25 * n);
	xx = matrix(nrow = 2, ncol = n);
	xx[1,] = t(data[,p1]) * t(data[,11]) / 100;
	xx[2,] = t(data[,p2]) * t(data[,11]) / 100;
	maxvalue = max(xx[2,]) * 1.1;
	par(mar=c(0.1,4.5,3.0,0.0));
	barplot(xx, horiz=TRUE, beside=TRUE, col=c(2,4), xaxt = 'n', yaxt = 'n', xlim = c(0, maxvalue));
	axis(3, tck = -0.025, mgp = c(0, 0.6, 0), pos = n * 3 + 1);
	axis(3, tick = FALSE, pos = n * 3 + 3, at = c(maxvalue * 0.45), labels = c(title));
	axis(2, tick = FALSE, las = 1, at = c(1:n) * 3 - 1, labels = t(data[,1]), mgp = c(0, 0.3, 0));
	px = maxvalue;
	py = 5.5;
	if(flag > 0)
	{
		legend(px, py, c(t2, t1), col = c(4,2), fill = c(4,2), bty='n', cex = 1, xjust = 1, x.intersp = 0.5);
	}
	dev.off();
}
