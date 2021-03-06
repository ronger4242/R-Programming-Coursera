#Getting started
getwd()
setwd("C:\\Users\\Nancy Zhao\\Desktop\\R-language\\Coursera\\R programming")
dir() #tells us what files or directories are available in the wd.

myfunction<-function() {
  x<-rnorm(100)
  mean(x)
}

second<-function(x){
  x+rnorm(length(x))
}
ls#nothing will return. It returns a vector of character strings giving the names of the objects in the specified environment.

#vector(length) can be used to create an empty vector
class(1) #gives a numeric object
class(1L) #gives an integer

#NaN: not a number or a missing value

#Attributes of R objects
#name, dimnames
#dimensions(e/g/ ,atroces,arrays)
#class
#length
#other user-defined attributes
#attribute() can be used to set or modify the attributes for an R object
x <- c(0.5, 0.6) ## numeric
x <- c(TRUE, FALSE) ## logical
x <- c(T, F) ## logical
x <- c("a", "b", "c") ## character
x <- 9:29 ## integer
x <- c(1+0i, 2+4i) ## complex

#vector():produces a vector of the given length and mode
x<-vector(length=10)
x
x<-vector("numeric", length=10)
x
x<-vector("character", length=10)
x

#mixed objects: coersion 
y <- c(1.7, "a") ## character
y <- c(TRUE, 2) ## numeric (True=1, False=0)
y <- c("a", TRUE) ## character

x<-0:6
class(x)
as.numeric(x)
as.logical(x)
as.character(x)

#list() can contain elements of different classes.
x<-list(1,"a", TRUE, 1+4i) #the elements are indexed with [[]]
x

#matrices: an integer vector of length 2(nrow, ncol)
m<-matrix(1:6,nrow=2,ncol=3)
m
dim(m)
attributes(m)

#Matrices are constructed through columns: upper-left from top to down.

#dim(): assign the dimensions to the matrix
m<-1:10
dim(m)<-c(2,5)
m
class(m)
#cbind, rbind
x <- 1:3
y <- 10:12
cbind(x, y)
class(z)
rbind(x, y)

#factor: categorical data (ordinal and nominal)
x <- factor(c("yes", "yes", "no", "yes", "no"))
y<-c("yes", "yes", "no", "yes", "no")
x
y
table(x)
table(y)
class(x)
class(y)
unclass(x) # strip off the class for a vector

#define the order of factor: the first level is the baseline level(importatnt in regression)
x <- factor(c("yes", "yes", "no", "yes", "no"),
              levels = c("yes", "no"))
x

#missing values: Na, NaN(undefined mathematical operations)
#is.na()  is.nan()
#NA values have a class also, so there are integer NA, character NA, etc
x <- c(1, 2, NA, 10, 3)
is.na(x)
is.nan(x)
x <- c(1, 2, NaN, NA, 4)
is.na(x)
is.nan(x)

#dataframe(): is used to store tabular data. It is a special type of list.
#difference between dataframe and list: each column in dataframe must have the same length; 
#difference between dataframe and matrix: each column in dataframe can be different data type.
#special attribute: row.names
#calling command:  read.table() or read.csv() or data.frame()
#be converted to a matrix: data.matrix()
x<-data.frame(foo=1:4, bar=c(T,T,F,F))
x
dim(x); ncol(x); nrow(x)

codes <- c(380,124,818)
country <- c ("italy", "canada", "egypt")
names(codes) <- country 
codes
as.data.frame(codes)
class(codes)
#names()
x<-1:3
x
names(x)<-c("foo","bar","norf")
names(x)

x<-list(a=1,b=T,c="banana")
x

m<-matrix(1:4,nrow=2,ncol=2)
dimnames(m)<-list(c("a","b"),c("c","d")) #rownames, colnames, must use list
m

#reading data (read.csv is identical to read.table except that the default separator is a comma.)
#read.table, read.csv, for reading tabular data
#readLines, for reading lines of a text file
#source, for reading in R code files (inverse of dump)
#dget, for reading in R code files (inverse of dput)
#load, for reading in saved workspaces
#unserialize, for reading single R objects in binary form

#writing data
#write.table
#writeLines
#dump
#dput
#save
#serialize

#the arguments of read.table
#file, the name of a file, or a connection
#header, logical indicating if the file has a header line
#sep, a string indicating how the columns are separated
#colClasses, a character vector indicating the class of each column in the dataset
#nrows, the number of rows in the dataset
#comment.char, a character string indicating the comment characterc  The default is #
#skip, the number of lines to skip from the beginning. skip=2
#stringsAsFactors, should character variables be coded as factors?

#For small to moderately sized datasets, you can usually call read.table without specifying any other arguments
setwd("C:\\Users\\Nancy Zhao\\Desktop\\R-language\\Coursera\\R programming")
data <- read.table("foo.txt",header=T, sep=" ")

#reading large tables: to speed up, we need to tell the computer what the classes are for columns. 
#we can first read a few columns, like 100, get the class, then use colClasses when we get the whole dataset.
initial<-read.table("Temperature.txt",nrows=20)
class_initial<-sapply(initial,class)
class_initial
tableall<-read.table("Temperature.txt", colClasses=class_initial)

#Textual formats
#dputing and dumping
#dput:
y<-data.frame(a=c("1","2","3"),b=c("a","b","c"),c=c(T,T,F))
y$a<-y$a+5
str(y)#column as has been changed ,thus it is logi NA.
a<-dput(y)
a
str(a)
#change a column from factor into integer and then add 5 onto it.
a$a<-as.integer(a$a)+5
#new a
a
#or we can edit the structure list:
new_a<-structure(list(a = structure(6:8, .Label = c("1", "2", "3"), class = "integer"), 
                      b = structure(1:3, .Label = c("a", "b", "c"), class = "factor"), 
                      c = c(TRUE, TRUE, FALSE)), class = "data.frame", row.names = c(NA, 
                                                                                 -3L))
new_a 
#dput deparses one object, where dump deparses multiple objects.
x<-"foo"
y<-data.frame(a=1,b="a")
z<-dump(c("x","y"),file="dump.R")
z
rm(x,y) #remove a and y
source("dump.R") #reconstruct x and y
x;y


#interface to the outside world
  #file, opens a connection to a file
  #gzfile, opens a connection to a file compressed with gzip
  #bzfile, opens a connection to a file compressed with bzip2
  #url, opens a connection to a webpage


str(file)#check the structure of the file function
con<-file("Temperature.txt", "r") #r: read only; w:writing; a:appending)
temp1<-readLines(con,10) #read the first 10 lines
temp1

con1<-url("https://gssdataexplorer.norc.org/variables/1/vshow","r")
x<-readLines(con1)
head(x)

#subsetting data
#[]
#[[]]: extract elements of a list or a datframe. 
#$: extract some elements.
x <- c("a", "b", "c", "c", "d", "a")
x[x > "a"]
u <- x > "a"
u
x[u]

#subsetting lists
x<-list(foo=1:4,bar=0.6)
x
x[1] #get a list that contains foo
x[[1]] #get the levels of the first element, which is foo.
x[[1]][2] #get the second element of foo
x[[2]][2] #returns NA coz bar only has one element
x$bar #equals to x[[2]] or x[["bar"]]

#extract multiple elements from the list
x<-list(foo=1:4, bar=0.6, baz="Hello")
x[c(1,3)] #get two lists: foo and baz
x[[c(2,1)]] #wrong, it will get the bar's first element.

#the difference between [[]] and $: [[]] can be used with computed indices; $ can be used with literal names
name<-"foo"
x[name]#get the list of foo.
x[[name]] #get the levels of foo
x$foo #get the levels of foo
x$name #null, name does not exist in the x list.

#subsetting nested elements of a list
x<-list(a=list(10,12,14),b=c(3.14,2.81))
x[[c(1,2)]] #get the second element of the first element which is 12
x[c(1,2)] #get the first and the second element which are a and b

#subsetting a matrix
x<-matrix(1:6,2,3)
x[1, 2]
x[2, 1]

x[1,]
x[,1]

#By default, when a single element of a matrix is retrieved, it is returned as a vector of length 1 rather
#than a 1 C 1 matrix. This behavior can be turned off by setting drop = FALSE.
x<-matrix(1:6,2,3)
x[1, 2] #it returns a vector
x[1,2,drop=F] #it returns a matrix. Drop means dropping the dimension

#partial matching: is allowed with [[exact=F]] and $
x<-list(aardvark=1:5,something=6:10) 
x$a
x[["a",exact=F]]
#if there are two names with a, it does not work
x<-list(aardvark=1:5,as=6:10) 
x$a #returns NULL

#removing NA values: create a logical vector that tells you where the NAs are.
x<-c(1,2,NA,4,NA,5)
bad<-is.na(x)
bad #returns FALSE FALSE  TRUE FALSE  TRUE FALSE
x[!bad]
y<-na.omit(x)
y

#remove NAs for multiple things: complete.cases()
#complete.cases():Return a logical vector indicating which cases are complete, i.e., have no missing values.
x<-c(1,2,NA,4,NA,5)
complete.cases(x)
is.na(x)
y<-c("a","b",NA,"d",NA,"f")
good<-complete.cases(x,y)
good #returns TRUE  TRUE FALSE  TRUE FALSE  TRUE
x[good]
y[good]

#when x and y have different length: error
x<-c(1,2,NA,4,NA)
y<-c("a","b",NA,"d",NA,"f")
good<-complete.cases(x,y)

#when x and y have different patterns, it returns the pattern of the most NAs.
x<-c(1,2,NA,4,NA,NA)
y<-c(NA,"b",NA,"d",NA,"f")
good<-complete.cases(x,y)
good #returns: FALSE(y's)  TRUE FALSE  TRUE FALSE FALSE(x's)

good1<-complete.cases(x)
good1

data(airquality)
good<-complete.cases(airquality)
good
airquality[good,][1:6,] #but the problem is that it will delete the whole rows

#vectorized operations
x <- 1:4; y <- 6:9
x;y
x+y

#when x and y have different lengths, there will be an error msg
x <- 1:5; y <- 6:9
x+y #does not work

x <- 1:4; y <- 6:9
x;y
x*y #element-wise multiplication
x/y #element-wise division


#vectorized matrix operation
x<-matrix(1:4,2,2); y<-matrix(rep(10,4),2,2)
x;y
x*y #element-wise multiplication
x%*%y #true matrix multiplication

x <- c(3, 5, 1, 10, 12, 6)
x %in% 1:5
x[x %in% 1:5] <- 0
x
#Homework week 1
hw1<-read.csv(file="C:\\Users\\Nancy Zhao\\Desktop\\R-language\\Coursera\\R programming\\hw1_data.csv",header=T)
hw1[1:2,]
hw1[152:153,]
hw1[47,1]
sum(is.na(hw1[,1]))
bad<-is.na(hw1[,1])
bad
ozone<-hw1[,1][!bad]
mean(ozone)

ozone31<-hw1$Ozone>31
ozone31
temp90<-hw1$Temp>90
temp90
index1<-ozone31&temp90
index1
solar_index1<-na.omit(hw1$Solar.R[index1])
mean(solar_index1)

index2<-hw1$Month==6
mean(hw1$Temp[index2])

index3<-hw1$Month==5
index3
max(na.omit(hw1$Ozone[index3]))

install.packages('swirl')
packageVersion('swirl')
library('swirl')
install_from_swirl('R Programming')
swirl()

