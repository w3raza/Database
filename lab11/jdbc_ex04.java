import java.sql.*;
import java.util.Scanner;
public class jdbc_ex04 {
  public static void main(String[] argv) {
  /*
  System.out.println("Sprawdzenie czy sterownik jest zarejestrowany w menadzerze");
  try {
    Class.forName("org.postgresql.Driver");
  } catch (ClassNotFoundException cnfe) {
    System.out.println("Nie znaleziono sterownika!");
    System.out.println("Wyduk sledzenia bledu i zakonczenie.");
    cnfe.printStackTrace();
    System.exit(1);
  }
  System.out.println("Zarejstrowano sterownik - OK, kolejny krok nawiazanie polaczenia z baza danych.");
  */
  Connection c = null;
  
  try {
    // Wymagane parametry polaczenia z baza danych:
    // Pierwszy - URL do bazy danych:
    //        jdbc:dialekt SQL:serwer(adres + port)/baza w naszym przypadku:
    //        jdbc:postgres://pascal.fis.agh.edu.pl:5432/baza
    // Drugi i trzeci parametr: uzytkownik bazy i haslo do bazy 
    c = DriverManager.getConnection("jdbc:postgresql://localhost:5432/u9zaczyk",
                                    "u9zaczyk", "9zaczyk");
  } catch (SQLException se) {
    System.out.println("Brak polaczenia z baza danych, wydruk logu sledzenia i koniec.");
    se.printStackTrace();
    System.exit(1);
  }
if (c != null) {
    System.out.println("Polaczenie z baza danych OK ! ");
    try { 
      //  Wstawianie rekordow do bazy danych
      //  Wykorzystanie metody executeUpdate()                                             
       PreparedStatement pst = c.prepareStatement("SELECT id_uczestnik, nazwisko, imie, email FROM lab04.uczestnik WHERE id_uczestnik=? AND nazwisko=? AND imie =? AND email=?", ResultSet.TYPE_SCROLL_SENSITIVE,ResultSet.CONCUR_UPDATABLE);
       pst.setInt(1,1) ;
       pst.setString(2,"Flisikowski") ;
       pst.setString(3,"Jan") ;
       pst.setString(4,"flisikowski@fis.agh.edu.pl") ;
       ResultSet rs = pst.executeQuery();
       while (rs.next())  {
       String email   = rs.getString("email") ;

       System.out.println("Wpisz nowy email: ");
       Scanner scanner = new Scanner(System.in);
       String newEmail = scanner.nextLine();

       System.out.println("Zmiana emaila: " + email + " na: " + newEmail) ; 
       pst = c.prepareStatement("UPDATE lab04.uczestnik SET email='" + newEmail + "' WHERE id_uczestnik = 1");
       }
       rs.close();
       
       pst.close();    
     }
     catch(SQLException e)  {
	     System.out.println("Blad podczas przetwarzania danych:"+e) ;   }	     
 
 }
  else
    System.out.println("Brak polaczenia z baza, dalsza czesc aplikacji nie jest wykonywana.");   }
} 

