---
layout: default
title: "Pieces of code- Bash"
---



### Find file with specific content 

```{bash}
find . -type f -name '*.R' -exec grep -l "pattern"  {} \;
```

similar to:

```
find folder -type f -name '*.R' | xargs  grep "pattern"
```

### Print start/end of a script

```{bash}

start_time=$(date -R)    
set -e

[...]

echo "*** DONE"
end_time=$(date -R)    
echo $start_time
echo $end_time
exit 0
``` 


### Execute a function before exiting the script

```{bash}
function mvBack {
  echo "... go back to my folder"
  cd $runDir  
}
trap mvBack EXIT
```


### Move file in for-loop

```{bash}
for file in *.jpg ; do mv $file ${file//IMG/myVacation} ; done
```

### Interpolate between number range for for-loop

```{bash}
for chromo in ( "chr"{1..22} ); do echo $chromo; done
```


### Read line by line from file

```{bash}
cat ./SAMPLES.txt| while read SAMPLE
do
    mkdir ${OUTDIR}/${SAMPLE}
done
```



### Copy to new file with substituted file name

```{bash}
cp top-words-{1,2}.sh # copy 1 to 2
```

### Space usage by disks: 

```
df -h
```

### Space usage for a given folder:

```
du -sh FOLDER_NAME
```

