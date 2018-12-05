#include <stdio.h>
#include <stdlib.h>

#define INPUT_SIZE 1025
#define CYCLE_LIMIT 1000


int is_in_array(int val, const int *arr, int size){
    for (int i=0; i < size; i++) {
        if (arr[i] == val)
            return 1;
    }
    return 0;
}

//  Advent of Code 2018 - Day 1 part II
int main(int argc, char **argv)
{
    FILE *fp;
    size_t len = 0;
    char *line = NULL;
    int frequencies[INPUT_SIZE];
    int accumsize = INPUT_SIZE;
    int *accumulation = (int*) malloc(accumsize *sizeof(int));
    int freq = 0;
    int i = 0;
    int cycle = 0;
    int currentaccumulationsize = 0;

    fp = fopen(argv[1], "r");

    // Load the frequencies from a file
    while (getline(&line, &len, fp) != -1) {
        frequencies[i] = atoi(line);
        i++;
    }

    accumulation[0] = freq;
    freq = 0;

    // Cycle through the frequencies until a duplicate is found
    while (cycle < CYCLE_LIMIT) {
        for (i=0; i < INPUT_SIZE; i++) {
            currentaccumulationsize = i + cycle * INPUT_SIZE;

            if (currentaccumulationsize == accumsize) {
                accumsize += INPUT_SIZE;
                accumulation = realloc(accumulation, accumsize * sizeof(int));
            }

            freq += frequencies[i];

            if (is_in_array(freq, accumulation, currentaccumulationsize) == 1) {
                printf("Found: %d", freq);
                cycle = CYCLE_LIMIT;
                break;
            }

            accumulation[currentaccumulationsize] = freq;
        }
        cycle++;
    }

    free(accumulation);
    return 0;
}
