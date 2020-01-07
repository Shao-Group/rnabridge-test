summarize = function(datafile, outputfile)
{
	data = read.table(datafile);
	result = 1:16;
	result[1 * 2 - 1] = mean(data[,4]);
	result[2 * 2 - 1] = mean(data[,8]);
	result[3 * 2 - 1] = mean(data[,6]);
	result[4 * 2 - 1] = mean(data[,10]);
	result[5 * 2 - 1] = mean(data[,16] * data[,11] / 100);
	result[6 * 2 - 1] = mean(data[,17] * data[,11] / 100);
	result[7 * 2 - 1] = mean(data[,13]);
	result[8 * 2 - 1] = mean(data[,14]);

	result[1 * 2 + 0] = sd(data[,4]);
	result[2 * 2 + 0] = sd(data[,8]);
	result[3 * 2 + 0] = sd(data[,6]);
	result[4 * 2 + 0] = sd(data[,10]);
	result[5 * 2 + 0] = sd(data[,16] * data[,11] / 100);
	result[6 * 2 + 0] = sd(data[,17] * data[,11] / 100);
	result[7 * 2 + 0] = sd(data[,13]);
	result[8 * 2 + 0] = sd(data[,14]);

	sink(outputfile, append = TRUE);
	cat(datafile, format(result, digits = 3), "\n");
	sink();
}
