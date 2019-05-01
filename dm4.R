library("TSP")
concorde_path("/Users/nityasriram/Desktop/dm4/concorde_3/TSP")

# Define functions Infinitise and Symmetrise
infinitise <- function(net){
for (i in 1:nrow(net)) { 
  for (j in 1:ncol(net)){
    if (net[i,j] < 0.000000000000001) {net[i,j] = Inf}
  }  
}
return(net)
}

symmetrise <- function(net) { 
for (i in 1:nrow(net)){ 
  for (j in 1:i){
    net[j,i] = net[i,j]
  }  
}
return(net)
}

ToDist <- function(net){ 
  result = c()
  for (i in 1:(nrow(net)-1)){
    result = c(result, net[i,(i+1):ncol(net)])
  }
  return(result)
}

# Define a funtion to solve using Concorde code
solve_network <- function(net)
{# Remove indices
  net <- as.matrix(net[,-1])
  
  # Initialise an arbitrary distance matrix 
  net.dist <- dist(net)
  
  # Fill the distance matrix with the values below the diagonal of net
  net.dist[1:length(net.dist)] <- ToDist(net)
  
  # Infinitise 
  net.dist[net.dist < 0.000000000000001] = Inf
  
  # TPS-ise
  net.tsp = as.TSP(net.dist)
  net.answer = solve_TSP(net.tsp, method = "concorde")
  return(net.answer)
}



# Load CSVs
net1 <- read.csv("net1.csv")
net2 <- read.csv("net2.csv")
net3 <- read.csv("net3.csv")
net4 <- read.csv("net4.csv")
#net5 <- read.csv("net5.csv")

net1.answer <- solve_network(net1)
net2.answer <- solve_network(net2)
net3.answer <- solve_network(net3)
net4.answer <- solve_network(net4)
#net5.answer <- solve_network(net5)

write_net <- function(net, filename) {
x = as.vector(net)
col1 = x[1:(length(x)-1)]-1
col2 = x[2:length(x)]-1
df = cbind(as.data.frame(col1), as.data.frame(col2))
write.table(df, filename, row.names = FALSE, col.names = FALSE)
}

write_net(net1.answer, "net1answer.txt")
write_net(net2.answer, "net2answer.txt")
write_net(net3.answer, "net3answer.txt")
write_net(net4.answer, "net4answer.txt")
#write_net(net5.answer, "net5answer.txt")

# This is a test run with the US50CA data
concorde_path("/Users/nityasriram/Desktop/dm4/concorde_3/TSP/")
data("USCA50")
this = solve_TSP(USCA50, method = "concorde") # this line generates the error message below 
