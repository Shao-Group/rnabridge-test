summarize.5 = function(datafile, outputfile, aligner)
{
	data = read.table(datafile);
	result = 1:33;
	for (k in seq(1,33))
	{
		result[k] = mean(data[,k+2]);
	}

	sink(outputfile, append = TRUE);
	cat(aligner, "XXX", format(result, digits = 6), "\n");
	sink();
}

summarize.3 = function(datafile, outputfile)
{
	data = read.table(datafile);
	result = 1:24;
	result[1 * 2 - 1] = mean(data[,13]);
	result[2 * 2 - 1] = mean(data[,9]);
	result[3 * 2 - 1] = mean(data[,5]);
	result[4 * 2 - 1] = mean(data[,15]);
	result[5 * 2 - 1] = mean(data[,11]);
	result[6 * 2 - 1] = mean(data[,7]);
	result[7 * 2 - 1] = mean(data[,19]);
	result[8 * 2 - 1] = mean(data[,18]);
	result[9 * 2 - 1] = mean(data[,17]);
	result[10* 2 - 1] = mean(data[,23]);
	result[11* 2 - 1] = mean(data[,22]);
	result[12* 2 - 1] = mean(data[,21]);

	result[1 * 2 - 0] = sd(data[,13]);
	result[2 * 2 - 0] = sd(data[,9]);
	result[3 * 2 - 0] = sd(data[,5]);
	result[4 * 2 - 0] = sd(data[,15]);
	result[5 * 2 - 0] = sd(data[,11]);
	result[6 * 2 - 0] = sd(data[,7]);
	result[7 * 2 - 0] = sd(data[,19]);
	result[8 * 2 - 0] = sd(data[,18]);
	result[9 * 2 - 0] = sd(data[,17]);
	result[10* 2 - 0] = sd(data[,23]);
	result[11* 2 - 0] = sd(data[,22]);
	result[12* 2 - 0] = sd(data[,21]);

	sink(outputfile, append = TRUE);
	cat(datafile, format(result, digits = 3), "\n");
	sink();
}

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
