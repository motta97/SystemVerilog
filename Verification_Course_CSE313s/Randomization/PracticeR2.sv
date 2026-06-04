// Write constraints to create a random array of integers such that array size is 
// between 10 and 20 and the values of the array are in descending order, and the 
// elements of the array are less than 30. 
class test;
rand int dyn[];
constraint c{
    dyn.size()>=10;
    dyn.size()<=20;
    foreach(dyn[i]){
        dyn[i]<30;
        if(i>0){
            dyn[i]<dyn[i-1];
        }
    }
}
endclass