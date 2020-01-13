#Control structure: usually used in a function
#if, else: testing a condition
#for: execute a loop a fixed number of times
#while: execute a loop while a condition is true
#repeat: execute an infinite loop
#break: break the execution of a loop
#next: skip an interation of a loop
#return: exit a function

#if, if else
if(x>3){
    y<-10
} else{
    y<-0
}

# equals to:
y<-if(x>3){
    10
} else{
    0
}

#for loop: use a loop index
for (i in 1:10){
    print(i)
}

#seq_along() creat an integer vector that has the same length as the input v.s. seq()
a<-c(8,9,10)
b<-c(9,10)
c<-10

seq_along(a) # 1 2 3
seq_along(b) #1 2
seq_along(c) #1 
seq(a) #1 2 3
seq(b) #1 2
seq(c) #1 2 3 4 5 6 7 8 9 10
seq_len(a)#:1 2 3 4 5 6 7 8
seq_len(b)#:1 2 3 4 5 6 7 8 9
seq_len(c)#:1  2  3  4  5  6  7  8  9 10
# The followings print out the same results.
x<-c("a","b","c","d")
for (i in 1:4){
    print(x[i])
}

for (i in seq_along(x)){
    print(x[i])
}

for (letter in x){
    print(letter)
}

for (i in 1:4) print(x[i]) #for single expression we can drop the {}

#nested for loop (be careful as nesting beyond 2-3 levels is hard to read)
x<-matrix(1:6,2,3)
seq_len(nrow(x))#1 2
seq_len(ncol(x))#1 2 3
for (i in seq_len(nrow(x))){
    for(j in seq_len(ncol(x))){
        print(x[i,j])
    }
}

#while loop: be careful it can potentially result in inifite loops if not written properly.
count<-0
while(count<10){
    print(count)
    count<-count+1
}
#for loop has a hard limit.

z<-5
while(z>=3 & z<=10){
    print(z)
    coin<-rbinom(1,1,0.5) #rbinom(n, size, prob)
    if(coin==1){ ##random walk
        z<-z+1
    } else{
        z<-z-1
    }
}

#repeat initiates an infinite loop, yet it is not commmon.

#next, return
#next is used to skip an interation for a loop (like continue in python)

for (i in 1:100){
    if(i<=20){
        next #skip the first 20 iterations
    }
    print(i)
}

#function
above<-function(x,n){
    index<-x>n
    x[index] #subset the x elements that are greater than n.
}
above(x=c(2,3,10,5),4)

#set the default n:
above<-function(x,n=10){
    index<-x>10
    x[index] #subset the x elements that are greater than 10.
}
above(x=1:20)

columnmean<-function(y, removeNA=T){
    nc<-ncol(y)
    means<-numeric(nc)#empty vector, numeric(length=2)
    for (i in 1:nc){
        means[i]<-mean(y[,i],na.rm=removeNA) # na.rm=T also works, but the prob is if we override removeNA=F, this part will not change.
    }
    means
}

columnmean(airquality)
columnmean(airquality, FALSE) #NAs will come back

#some concepts and definitions about function
#The formal arguments are the arguments included in the function definition.
#argument matching: by name or by position. But if the argument list is long, by name would be better.
#"...": the ... argument indicates a number of arguments that are usually passed on to other functions:
#1.we do not need to copy the entire argument list of the original function.
#2. we do not know how many arguments passed to the funciton in adavnce.

myplot<-function(x,y,type="l",...){
    plot(x,y,type=type,...)
} # except type="l", the rest arguments will be the same as the original plot function.

args(paste)
#function (..., sep = " ", collapse = NULL) #We do not know how many strings will be pasted, thus we use ...

f<-function(x,y){
    x^2+y/h  #h is the free variable, but it is not defined in this case.
}

#lexical scoping
make.power<-function(n){
    pow<-function(x){
        x^n #n is the free variable in this function pow.
    }
    pow
}

cube<-make.power(3) #assign 3 to n
cube(2) #assign 2 to x

square<-make.power(2)
square(2)

#scoping rules:determine how a value is associated with a free variable in a function.
    #when a function is called, R will search from the global environment and then down the list of search().
    #when we load a package with library, the package will gets put in position 2 of the search list.
    #R uses lexical scoping/static scoping. An alternative is dynamic scoping.

#enviornment:
    #it is a collection of symbol value pairs.
    #every environment has a parent environment.
    #a function+an enviroment=a closure or function closure.

#lexical v.s. dynamic scoping

f<-function(x,y){
    x^2+y/z
}
#z is a free variable. 
    #the values of free variables are searched for in the environment in which the function was defined.
    #if R cannot find the value, then the search continues down the sequence of parent environments until hit the global environment.

y<-10
f<-function(x){
    y<-2
    y^2+g(x) # It looked up in the local environment where the function wqas called.
}

g<-function(x){ #No value was found for y in the local environment, so it looks up in the global envrionment for y.
    x*y
}

f(3)

#constructor function: constructs the objective function.
#objective function: have all of the data, and all of the other things included 
#in the environment of that function(like a block)
#maximum likelihood estimation: ???????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????

#the <<- operator which can be used to assign a value to an object in an environment that is different from the current environment
#makeVector: builds a set of functions and returns the functions within a list to the parent environment.
makeVector <- function(x = numeric()) {
    m <- NULL #m <- NULL begins by setting the mean to NULL as a placeholder for a future value
    set <- function(y) {#defines a function to set the vector, x, to a new vector, y, and resets the mean, m, to NULL
        x <<- y
        m <<- NULL 
    }
    get <- function() x #returns the vector, x
    setmean <- function(mean) m <<- mean #sets the mean, m, to mean
    getmean <- function() m #returns the mean, m
    list(set = set, get = get, #returns the 'special vector' containing all of the functions just defined
         setmean = setmean,
         getmean = getmean)
}
myVector<-makeVector(1:15) #returns four functions(set, get, setmean, getmean) and two data objects(x,m)
myVector #returns a list of four functions.
myVector$get() #returns 1  2  3  4  5  6  7  8  9 10 11 12 13 14 15. 


cachemean <- function(x, ...) {
    m <- x$getmean()
    if(!is.null(m)) {
        message("getting cached data")
        return(m)
    }
    data <- x$get()
    m <- mean(data, ...)
    x$setmean(m)
    m
}
#https://stackoverflow.com/questions/34811462/r-what-does-the-small-function-do-when-it-is-not-called-from-anywhere
#coding standard
#1. Always use text files / text editor
#2. Indent your code. Indents of 4 spaces at minimum; 
    #8 spaces ideal: use ctrl+A to select all codes, use ctrl+i to indent all codes
#3. Limit the width of your code (80 columns?)
#4. Limit the length of individual functions. Split them into a few logical independent functions.

#Dates and times
   #Dates are represented by the Date class. Stored as the number of days since 1970-01-01.
   #Times are represented by the POSIXct or the POSIXlt class. Stored as the number of seconds since 1970-01-01.
        #POSIXct(integer)    POSIXlt(list)
#as.Date(): convert a character string into POSIXct format date.
x<-as.Date ("1971-01-02")
x
unclass(x) # when we unclass x, it is 366, meaning 366 days from 1970-01-01

#weekdays, months, quarters that are associated with time
weekdays(x)
months(x)
quarters(x)
weekdays(as.Date("1985-04-02"))

# times can be coerced from a character string using as.POSIXct or as.POSIXlt
x<-Sys.time()
x
class(x) # "2019-05-10 13:55:19 PDT" is POSIXct already. Convert it to POSIXlt.
y<-as.POSIXlt(x)
y
class(y)
#cannot tell the differences between x and y at this point. Try to unclass them
unclass(x) #1557521720: How many seconds have passed since 1970-01-01.
unclass(y) # a list of sec, min, hour, mday, mon, year, wday, yday, isdst
x$sec #error
y$sec #19.68204 get the result of the sec list.

#strptime(): is used to change date format. B:Month(full name); b:month(abbreviated); Y:Year, H:Hour, M:minute
datestring<-c("January 10, 2012 10:40", "December 9, 2011 9:10")
x<-strptime(datestring, "%B %d, %Y %H:%M")
y<-strptime(datestring, "%b %d, %Y %H:%M")
x
y
class(x)

#data and time operations
x<-as.Date("2012-01-01")
y<-strptime("9 Jan 2011 11:34:21", "%d %b %Y %H:%M:%S")
x
y
class(x)
class(y)
x1<-as.POSIXlt(x)
x1-y #Time difference of 356.1845 days