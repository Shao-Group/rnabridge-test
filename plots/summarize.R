summarize = function(datafile, outputfile)
{
	data = read.table(datafile);
	result = 1:8;
	result[1] = floor(mean(data[,4]));
	result[2] = floor(mean(data[,8]));
	result[3] = mean(data[,6]);
	result[4] = mean(data[,10]);
	result[5] = floor(mean(data[,16] * data[,11] / 100));
	result[6] = floor(mean(data[,17] * data[,11] / 100));
	result[7] = mean(data[,13]);
	result[8] = mean(data[,14]);
	sink(outputfile, append = TRUE);
	cat(datafile, format(result[1:2], nsmall = 0), format(result[3:4], digits = 3, nsmall = 1), format(result[5:6], nsmall = 0), format(result[7:8], digits = 3, nsmall = 1), "\n");
	sink();
}
