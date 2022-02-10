import java.sql.*;
public class jdbc_ex02 {
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
      //  Wykonanie zapytania SELECT do bazy danych
      //  Wykorzystane elementy: prepareStatement(), executeQuery()
       PreparedStatement pst = c.prepareStatement("SELECT nazwisko, imie, kurs_opis.opis, kurs.id_kurs, kurs.id_grupa FROM lab04.kurs, lab04.uczest_kurs, lab04.uczestnik, lab04.kurs_opis WHERE kurs.id_kurs = uczest_kurs.id_kurs and id_uczestnik = uczest_kurs.id_uczest and kurs.id_nazwa = kurs_opis.id_kurs ORDER BY id_kurs, nazwisko, imie ", ResultSet.TYPE_SCROLL_SENSITIVE,ResultSet.CONCUR_UPDATABLE);
       ResultSet rs = pst.executeQuery();
       while (rs.next())  {
            //String id   = rs.getString("id") ;
            String imie    = rs.getString("imie") ;
            String nazwisko    = rs.getString("nazwisko") ;
            String opis    = rs.getString("opis") ;
            System.out.println(imie+" "+nazwisko + " " + opis) ;   }
       rs.close();
       pst.close();    }
     catch(SQLException e)  {
	     System.out.println("Blad podczas przetwarzania danych:"+e) ;   }	     
 
 }
  else
    System.out.println("Brak polaczenia z baza, dalsza czesc aplikacji nie jest wykonywana.");   }
} 

// Polaczenie z baza danych OK ! 
// Jan Flisikowski Język angielski, stopień 1
// Paweł Głowala Język angielski, stopień 1
// Grzegorz Iwanowicz Język angielski, stopień 1
// Marek Kotulski Język angielski, stopień 1
// Michał Łaski Język angielski, stopień 1
// Piotr Płochocki Język angielski, stopień 1
// Józef Straszewski Język angielski, stopień 1
// Stanisław Sztuka Język angielski, stopień 1
// Ryszard Bukowiecki Język angielski, stopień 1
// Łukasz Całus Język angielski, stopień 1
// Zbigniew Kołodziejek Język angielski, stopień 1
// Andrzej Olech Język angielski, stopień 1
// Henryk Radziszewski Język angielski, stopień 1
// Ryszard Bukowiecki Język angielski, stopień 2
// Jan Flisikowski Język angielski, stopień 2
// Paweł Głowala Język angielski, stopień 2
// Zbigniew Kołodziejek Język angielski, stopień 2
// Andrzej Olech Język angielski, stopień 2
// Piotr Płochocki Język angielski, stopień 2
// Henryk Radziszewski Język angielski, stopień 2
// Stanisław Sztuka Język angielski, stopień 2
// Jan Flisikowski Język angielski, stopień 3
// Mateusz Hołownia Język angielski, stopień 3
// Kazimierz Nawara Język angielski, stopień 3
// Andrzej Olech Język angielski, stopień 3
// Piotr Płochocki Język angielski, stopień 3
// Mariusz Szcześniak Język angielski, stopień 3
// Stanisław Sztuka Język angielski, stopień 3
// Jan Flisikowski Język angielski, stopień 4
// Kazimierz Nawara Język angielski, stopień 4
// Andrzej Olech Język angielski, stopień 4
// Piotr Płochocki Język angielski, stopień 4
// Mariusz Szcześniak Język angielski, stopień 4
// Stanisław Sztuka Język angielski, stopień 4
// Jerzy Barnaś Język niemiecki, stopień 1
// Marcin Dwojak Język niemiecki, stopień 1
// Adam Gzik Język niemiecki, stopień 1
// Rafał Matuszczak Język niemiecki, stopień 1
// Robert Rafalski Język niemiecki, stopień 1
// Dariusz Sielicki Język niemiecki, stopień 1
// Józef Straszewski Język niemiecki, stopień 1
// Ryszard Bukowiecki Język niemiecki, stopień 1
// Mirosław Chrobok Język niemiecki, stopień 1
// Mateusz Hołownia Język niemiecki, stopień 1
// Wojciech Kęski Język niemiecki, stopień 1
// Zbigniew Kołodziejek Język niemiecki, stopień 1
// Michał Łaski Język niemiecki, stopień 1
// Jacek Wolf Język niemiecki, stopień 1
// Jerzy Barnaś Język niemiecki, stopień 2
// Marcin Dwojak Język niemiecki, stopień 2
// Adam Gzik Język niemiecki, stopień 2
// Rafał Matuszczak Język niemiecki, stopień 2
// Robert Rafalski Język niemiecki, stopień 2
// Dariusz Sielicki Język niemiecki, stopień 2
// Józef Straszewski Język niemiecki, stopień 2
// Jerzy Barnaś Język niemiecki, stopień 3
// Marcin Dwojak Język niemiecki, stopień 3
// Rafał Matuszczak Język niemiecki, stopień 3
// Robert Rafalski Język niemiecki, stopień 3
// Józef Straszewski Język niemiecki, stopień 3
// Ryszard Bukowiecki Język hiszpański, stopień 1
// Łukasz Całus Język hiszpański, stopień 1
// Mirosław Chrobok Język hiszpański, stopień 1
// Janusz Kolczyński Język hiszpański, stopień 1
// Kazimierz Nawara Język hiszpański, stopień 1
// Robert Rafalski Język hiszpański, stopień 1
// Tomasz Sosin Język hiszpański, stopień 1
// Ryszard Bukowiecki Język hiszpański, stopień 2
// Łukasz Całus Język hiszpański, stopień 2
// Mirosław Chrobok Język hiszpański, stopień 2
// Janusz Kolczyński Język hiszpański, stopień 2
// Kazimierz Nawara Język hiszpański, stopień 2
// Robert Rafalski Język hiszpański, stopień 2
// Tomasz Sosin Język hiszpański, stopień 2