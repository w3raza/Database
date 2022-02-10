import java.sql.*;
public class jdbc_ex03 {
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
      boolean isFind = false;
      //  Wykonanie zapytania SELECT  z warunkiem WHERE 
      //  Wykorzystane elementy: setString, executeQuery
       PreparedStatement pst = c.prepareStatement("SELECT nazwisko, imie, kurs_opis.opis, kurs.id_kurs, kurs.id_grupa FROM lab04.kurs, lab04.uczest_kurs, lab04.uczestnik, lab04.kurs_opis WHERE kurs.id_kurs = uczest_kurs.id_kurs and id_uczestnik = uczest_kurs.id_uczest and kurs.id_nazwa = kurs_opis.id_kurs AND nazwisko=?", ResultSet.TYPE_SCROLL_SENSITIVE,ResultSet.CONCUR_UPDATABLE);
       pst.setString(1,"Hołownia");
       ResultSet rs ;
       rs = pst.executeQuery();
       while (rs.next())  {
            isFind = true;
            //String id   = rs.getString("id") ;
            String imie    = rs.getString("imie") ;
            String nazwisko    = rs.getString("nazwisko") ;
             String opis    = rs.getString("opis") ;
            System.out.print("Pytanie 1 - wynik:  ");
            System.out.println(imie+" "+nazwisko+ " " + opis) ;   
      }
      if(isFind==false)
          System.out.println("Nie znaleziono nikogo o takim nazwisku");
       rs.close();
       pst.setString(1,"NieMaTakiegoNazwiska");
       rs = pst.executeQuery();
       isFind=false;
       while (rs.next())  {
            isFind = true;
            //String id   = rs.getString("id") ;
            String imie    = rs.getString("imie") ;
            String nazwisko    = rs.getString("nazwisko") ;
            String opis    = rs.getString("opis") ;
            System.out.print("Pytanie 2 - wynik:  ");
            System.out.println(imie+" "+nazwisko+ " " + opis) ;   
        }
       if(isFind==false)
          System.out.println("Nie znaleziono nikogo o takim nazwisku");
       rs.close();
       pst.close();    
    }catch(SQLException e)  {
	     System.out.println("Blad podczas przetwarzania danych:"+e) ;   }	     
 
 }
  else
    System.out.println("Brak polaczenia z baza, dalsza czesc aplikacji nie jest wykonywana.");   }
} 

// Polaczenie z baza danych OK ! 
// Pytanie 1 - wynik:  Mateusz Hołownia Język angielski, stopień 3
// Pytanie 1 - wynik:  Mateusz Hołownia Język niemiecki, stopień 1
// Nie znaleziono nikogo o takim nazwisku