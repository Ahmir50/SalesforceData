public class AsyncExecutionOppReport implements Queueable {
public Integer StartInd ;
public Integer EndInd;
public List<string> contactIdsList ;

    public AsyncExecutionOppReport (Integer startIndex,Integer Endindex,List<String> Conlist){
        contactIdsList  = new List<string>();
        StartInd = startIndex;
        EndInd = Endindex;
        contactIdsList  =Conlist;    
    }
    public void execute(QueueableContext context) {
    
        List<String> colistforProcess = new List<String>();
        for(Integer i=StartInd;i<EndInd;i++){
            colistforProcess.add(contactIdsList[i]);    
        }        
        Preparereport rpt = new Preparereport ();
        rpt.getdata(colistforProcess);
        
   }
    
      
}