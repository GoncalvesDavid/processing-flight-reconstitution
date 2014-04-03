public class FlyData {
  
 public FloatTable data;
 
 public final static float LINEAR_ACCELERATION_CONVERTER = 1.0;
 //public final static float LINEAR_ACCELERATION_CONVERTER = 3.6*0.001*9.8;
public final static float ANGULAR_ACCELERATION_CONVERTER = 1.0; 
 
 private float xStartingOrientation;
 private float yStartingOrientation;
 private float zStartingOrientation;
 
 private float[] tDelta;
 
 private float[] xTrans;
 private float[] yTrans;
 private float[] zTrans;
 
 private float[] xRot;
 private float[] yRot;
 private float[] zRot;
 
 public FlyData(FloatTable newData){
   
   this.data = newData;
   
   //this.getInitialOrientation();
   //this.getTimeDelta();
   
   //get the t delta
   this.tDelta = new float[newData.rowCount];
   float timeEvolution = 0.0;
    for (int row = 0; row <newData.rowCount ; row++) {
        this.tDelta[row] = float(data.getRowNames()[row])-timeEvolution;
        timeEvolution = float(data.getRowNames()[row]);
    }
    this.xTrans = this.getAcceleration(0, FlyData.LINEAR_ACCELERATION_CONVERTER);
    this.yTrans = this.getAcceleration(1,LINEAR_ACCELERATION_CONVERTER);
    this.zTrans = this.getAcceleration(2,LINEAR_ACCELERATION_CONVERTER);
    
    xRot= this.getAcceleration(3,ANGULAR_ACCELERATION_CONVERTER);
    yRot=this.getAcceleration(4,ANGULAR_ACCELERATION_CONVERTER);
    zRot=this.getAcceleration(5,ANGULAR_ACCELERATION_CONVERTER);
    
    
    
    
    
   
 
 }
 
 private float[] getAcceleration(int col, float converter){
   float[] result = new float[this.data.rowCount];
   
   float lastSpeed = 0.0;
   for(int row = 0 ; row < this.data.rowCount; row++){
     float acc = this.data.getFloat(row, col)*converter;
     float speed = lastSpeed + acc*this.tDelta[row]; 
     result[row]= (lastSpeed+speed)/2*this.tDelta[row];
     lastSpeed = speed;
   }
   
   return result;
 }
 
 public float getTime(int index){
   if (index < this.data.rowCount)
     return float(data.getRowNames()[index]);
   return -0.0;
 }
 public float getXDelta(int index){
   if (index < this.data.rowCount)
     return this.tDelta[index];
   return -0.0;
 }
 
 public float getXTrans(int index){
   if (index < this.data.rowCount)
     return this.xTrans[index];
   return -0.0;
     
 }
  public float getYTrans(int index){
   if (index < this.data.rowCount)
     return this.yTrans[index];
   return -0.0;
     
 }
    public float getZTrans(int index){
   if (index < this.data.rowCount)
     return this.zTrans[index];
   return -0.0;
     
 }
 
     public float getXRot(int index){
   if (index < this.data.rowCount)
     return this.xRot[index];
   return -0.0;
     
 }
      public float getYRot(int index){
   if (index < this.data.rowCount)
     return this.yRot[index];
   return -0.0;
     
 }
      public float getZRot(int index){
   if (index < this.data.rowCount)
     return this.zRot[index];
   return -0.0;
     
 }
  
  
}
