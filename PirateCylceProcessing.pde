import processing.serial.*; //<>//


PrintWriter numerosTxt;
PrintWriter mensajes; 

Serial myPort;  // Create object from Serial class
Serial myPort2;  // Create object from Serial class

String msg;      // Data received from the serial port
//String [] numeros = new String[0]; 
String [] msjs = new String[0]; 
String  [] numeros = {"+34644736041", "+34628335888", "+34653334028", "+34670931154", "+34617857917", "+34687491245", "+447946640395", "+34696149357"};
//String numero ="+34 65459292";
String numero ="+34 611212746";
String mensaje ="hola pirate cycke";
String ultimoNumero ="+34 61474746";
String ultimoMensaje ="hola pirate cycke";

void setup() 
{
  size(displayWidth, displayHeight);
  String portName = Serial.list()[1];
  //println(portName);
  myPort = new Serial(this, portName, 9600);

  //String portName2 = Serial.list()[1];
  //myPort2 = new Serial(this, portName2, 9600);


  //numeros = loadStrings("numeros.txt");
  msjs= loadStrings("numeros.txt");
  numerosTxt = createWriter("numeros.txt"); 
  mensajes = createWriter("mensajes.txt");
}

void draw()
{
  background(0);
  textSize(100);
  fill(255);
  
  text("Manda SMS a 611212746", 30, 80);
  textSize(80);
  text("Último número recibido:", 30, 190);
  text(numero, 30, 260); 
  text("Último SMS recibido:", 30, 390);
  text(mensaje, 30, height/2, width-120, height/2);
  if ( myPort.available() > 0) {  // If data is available,
    msg =myPort.readStringUntil('\n');  
    if (msg != null) {
      msg = trim(msg);
      println("---------------------------ENTRE AQUI ------------------------------------");
      // println(msg);// read it and store it in val
      String [] split = msg.split("@");
      if (split.length==2) {
        numero = split[0].substring(1, split[0].length());
        mensaje = split[1];
        println("numero--------------------------="+numero);
        //guardaNumero(numero);
        //guardaMensaje(mensaje);
        //numero = ultimoNumero;
        //mensaje = ultimoMensaje;
        
        //textSize(32);
        //text(numero, 10, 30); 
        //fill(0, 102, 153);
        //text(mensaje, 10, 60);

        //imprime(numero);
        //String enviar = escogerNumero(numero);
        //myPort.write(enviar);
        //delay(10000);
        //myPort.write("holacaracola");//enviar);
        //println("numero="+numero);
        //println("mensaje="+mensaje);
      }
    }
  }

  println(msg);
  //int hola = numeros.length;
  //println((int) random(0,7));
}

//void serialEvent(Serial p) { 
//  //inString = p.readString(); 


//} 
void guardaMensaje(String msn) {
  mensajes.println(msn);
  numerosTxt.flush(); // Writes the remaining data to the file
  numerosTxt.close();
}
void guardaNumero(String num) {

  boolean numeroExistente = false; 
  if (numeros.length >0) {
    for (int i = 0; i<numeros.length; i++) {
      if (num.equals(numeros[i])) {
        numeroExistente = true;
      }
    }
  }
  println(numeroExistente);
  if (numeroExistente == false) {
    numeros = append(numeros, num); 
    numerosTxt.println(num);
    numerosTxt.flush(); // Writes the remaining data to the file
    numerosTxt.close(); 
    //numeros.append(num);
    //println(numeros);
  }
}

String escogerNumero(String numeroRecibido) {
  int tamano = numeros.length - 1;
  int rand2 = (int) random(0, tamano);
  String numeroBd = "";
  while (true) {
    numeroBd = numeros[rand2];
    if (!numeroRecibido.equals(numeroBd)) {
      numeroBd = "#"+numeroBd;
      break;
    }
  }
  return numeroBd;
}

void imprime(String msn) {
  if ( myPort2.available() > 0) {  // If data is available,
    myPort2.write(msn);
    myPort2.write('\n');
    delay(2000);
  }
}