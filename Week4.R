#str(): a diagnostic function and an alternative to 'summary'
str(lm)
str(ls)
x<-rnorm(100,2,4)
str(x)
summary(x)
f<-gl(40,10)
str(f)
summary(f) #gives frequency for each level

s<-split(airquality, airquality$Month)
str(s)
airquality$Month<-as.factor(airquality$Month)
str(airquality)

#generate random numbers
 #rnorm: generate random Normal variates with a given mean and standard deviation
 #dnorm: evaluate the Normal probability density (with a given mean/SD) at a point (or vector of                                                                                 points)
 #pnorm: evaluate the cumulative distribution function for a Normal distribution
 #qnorm: quantile function
 #rpois: generate random Poisson variates with a given rate

    #dnorm(x, mean = 0, sd = 1, log = FALSE)
    #pnorm(q, mean = 0, sd = 1, lower.tail = TRUE, log.p = FALSE) lower.tail means left tail.
    #qnorm(p, mean = 0, sd = 1, lower.tail = TRUE, log.p = FALSE)
    #rnorm(n, mean = 0, sd = 1)

#set.seed(): ensures reproducibility. The seed number can be any integer.
set.seed(1)
rnorm(5)

rnorm(5)

set.seed(1) #same as the first one.
rnorm(5)

set.seed(2)
rnorm(5)
set.seed(2)
rnorm(5)

#similar for poissan distribution
    #dpois(x, lambda, log = FALSE)
    #ppois(q, lambda, lower.tail = TRUE, log.p = FALSE)
    #qpois(p, lambda, lower.tail = TRUE, log.p = FALSE)
    #rpois(n, lambda)

#simulating a linear model
set.seed(20)
x<-rnorm(100)
e<-rnorm(100,0,2)
y<-0.5+2*x+e
summary(y)
plot(x,y)

#when x is a binary variable (e.g. gender)
set.seed(10)
x<-rbinom(100,1,0.5) #rbinom(n, size, prob)
e<-rnorm(100,0,2)
y<-0.5+2*x+e
summary(y)
plot(x,y)

#random sampling: sample()
set.seed(1)
sample(1:10,4)
sample(letters,5)
sample(1:10) #if we do not specify how many randome numbers we want from the list, it gives us a random order of these numbers.
sample(1:10, replace=T) #it returns repeated results.

#R profiler
#profiling: How much time is spent in different parts of the system.
#system.time(): how much time is taken to evaluate an expression.
#The values presented (user, system, and elapsed) will be defined by your operating system, but generally.
#the user time relates to the execution of the code, the system time relates to your CPU, and the elapsed time is the difference in times since you started the stopwatch (and will be equal to the sum of user and system times if the chunk of code was run altogether). 

#user time: time the CPU takes to run the expression. The time that computer experiences.
#elapsed time: wall clock time. The time that I experience.
    #elapsed time> user time: if the CPU spends a lot of time waiting(other things in the background).
    system.time(readLines("http://www.jhsph.edu"))
    #elapse time < user time: if the machine has multiple processors.
    hilbert<-function(n){
        i<-1:n
        1/outer(i-1,i, "+")
    }
    x<-hilbert(1000)
    svd(x)
    system.time(svd(x)) 
 #?????? ?????? ?????? 
    #3.40 0.03 3.85    
#the reason is the the linear alberga library uses two CPUs to run it. t1+t2>the time we waited.
    
#Rprof(): takes the output from the profiler and summarizes it in a way that is kind of readable.
#summaryRprof(): summarizes the output from Rprof() in table and calculates how much time is spent in which function.
#normalizing: 1)by.total: devides the time spent in each function by the total run time; 
    #2) by.self(more precise): does the same but first subtracts out time spent in functions above the call stack.

        