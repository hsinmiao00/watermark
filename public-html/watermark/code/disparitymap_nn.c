#include<stdio.h>
#include<stdlib.h>
#include<math.h>
#include<string.h>
//#include<omp.h>
struct featurepoint{
	double x;
	double y;
	int d;
};

int main(int argc, char* argv[]){
	int width;
	int height;
	int lines;
	int i,j,k;
	struct featurepoint* pointList;
	int **output;
	FILE* fp;
	char tmpStr[100];
	char *pch;
	int* tmpData;

	sscanf(argv[2],"%d", &lines);
	sscanf(argv[3],"%d", &height);
	sscanf(argv[4],"%d", &width);
	
	output = (int**)malloc(height*sizeof(int *) + width*height*sizeof(int) );	
	for(i=0, tmpData=(int*)(output+height) ; i<height ; i++ , tmpData += width )
		output[i] = tmpData;
	
	pointList = (struct featurepoint*)malloc(lines * sizeof(struct featurepoint));

	fp = fopen(argv[1],"r");	
	for(i=0;i<lines;i++){
		fgets( tmpStr, 90, fp );
		
		pch = strtok (tmpStr,",");
		sscanf(pch,"%lf",&(pointList[i].x));
		pch = strtok (NULL, ",");
		sscanf(pch,"%lf",&(pointList[i].y));	
		pch = strtok (NULL, ",\n");
		sscanf(pch,"%d",&(pointList[i].d));	
	}
	fclose(fp);

	fp = fopen(argv[5],"w");
	
	for(i=0;i<height;i++){
		for(j=0;j<width;j++){
			double minDist = 9999999.999;
			int nearest = 0;

			for(k=0;k<lines;k++){
				
				double tmpX = pointList[k].x;
				double tmpY = pointList[k].y;
				double distance = (j-tmpX)*(j-tmpX)+(i-tmpY)*(i-tmpY);
				if(distance < minDist){
					minDist = distance;
					nearest = k;
				}
			}
			output[i][j] = pointList[nearest].d;
		}
	}
		
	for(i=0;i<height;i++){
		for(j=0;j<width;j++){
			fprintf(fp,"%d,",output[i][j]);	
		}
		fprintf(fp,"\n");
	}
	
	fclose(fp);
	free(pointList);
	free(output);

	return 0;
}
