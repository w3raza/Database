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
// Jan Flisikowski J??zyk angielski, stopie?? 1
// Pawe?? G??owala J??zyk angielski, stopie?? 1
// Grzegorz Iwanowicz J??zyk angielski, stopie?? 1
// Marek Kotulski J??zyk angielski, stopie?? 1
// Micha?? ??aski J??zyk angielski, stopie?? 1
// Piotr P??ochocki J??zyk angielski, stopie?? 1
// J??zef Straszewski J??zyk angielski, stopie?? 1
// Stanis??aw Sztuka J??zyk angielski, stopie?? 1
// Ryszard Bukowiecki J??zyk angielski, stopie?? 1
// ??ukasz Ca??us J??zyk angielski, stopie?? 1
// Zbigniew Ko??odziejek J??zyk angielski, stopie?? 1
// Andrzej Olech J??zyk angielski, stopie?? 1
// Henryk Radziszewski J??zyk angielski, stopie?? 1
// Ryszard Bukowiecki J??zyk angielski, stopie?? 2
// Jan Flisikowski J??zyk angielski, stopie?? 2
// Pawe?? G??owala J??zyk angielski, stopie?? 2
// Zbigniew Ko??odziejek J??zyk angielski, stopie?? 2
// Andrzej Olech J??zyk angielski, stopie?? 2
// Piotr P??ochocki J??zyk angielski, stopie?? 2
// Henryk Radziszewski J??zyk angielski, stopie?? 2
// Stanis??aw Sztuka J??zyk angielski, stopie?? 2
// Jan Flisikowski J??zyk angielski, stopie?? 3
// Mateusz Ho??ownia J??zyk angielski, stopie?? 3
// Kazimierz Nawara J??zyk angielski, stopie?? 3
// Andrzej Olech J??zyk angielski, stopie?? 3
// Piotr P??ochocki J??zyk angielski, stopie?? 3
// Mariusz Szcze??niak J??zyk angielski, stopie?? 3
// Stanis??aw Sztuka J??zyk angielski, stopie?? 3
// Jan Flisikowski J??zyk angielski, stopie?? 4
// Kazimierz Nawara J??zyk angielski, stopie?? 4
// Andrzej Olech J??zyk angielski, stopie?? 4
// Piotr P??ochocki J??zyk angielski, stopie?? 4
// Mariusz Szcze??niak J??zyk angielski, stopie?? 4
// Stanis??aw Sztuka J??zyk angielski, stopie?? 4
// Jerzy Barna?? J??zyk niemiecki, stopie?? 1
// Marcin Dwojak J??zyk niemiecki, stopie?? 1
// Adam Gzik J??zyk niemiecki, stopie?? 1
// Rafa?? Matuszczak J??zyk niemiecki, stopie?? 1
// Robert Rafalski J??zyk niemiecki, stopie?? 1
// Dariusz Sielicki J??zyk niemiecki, stopie?? 1
// J??zef Straszewski J??zyk niemiecki, stopie?? 1
// Ryszard Bukowiecki J??zyk niemiecki, stopie?? 1
// Miros??aw Chrobok J??zyk niemiecki, stopie?? 1
// Mateusz Ho??ownia J??zyk niemiecki, stopie?? 1
// Wojciech K??ski J??zyk niemiecki, stopie?? 1
// Zbigniew Ko??odziejek J??zyk niemiecki, stopie?? 1
// Micha?? ??aski J??zyk niemiecki, stopie?? 1
// Jacek Wolf J??zyk niemiecki, stopie?? 1
// Jerzy Barna?? J??zyk niemiecki, stopie?? 2
// Marcin Dwojak J??zyk niemiecki, stopie?? 2
// Adam Gzik J??zyk niemiecki, stopie?? 2
// Rafa?? Matuszczak J??zyk niemiecki, stopie?? 2
// Robert Rafalski J??zyk niemiecki, stopie?? 2
// Dariusz Sielicki J??zyk niemiecki, stopie?? 2
// J??zef Straszewski J??zyk niemiecki, stopie?? 2
// Jerzy Barna?? J??zyk niemiecki, stopie?? 3
// Marcin Dwojak J??zyk niemiecki, stopie?? 3
// Rafa?? Matuszczak J??zyk niemiecki, stopie?? 3
// Robert Rafalski J??zyk niemiecki, stopie?? 3
// J??zef Straszewski J??zyk niemiecki, stopie?? 3
// Ryszard Bukowiecki J??zyk hiszpa??ski, stopie?? 1
// ??ukasz Ca??us J??zyk hiszpa??ski, stopie?? 1
// Miros??aw Chrobok J??zyk hiszpa??ski, stopie?? 1
// Janusz Kolczy??ski J??zyk hiszpa??ski, stopie?? 1
// Kazimierz Nawara J??zyk hiszpa??ski, stopie?? 1
// Robert Rafalski J??zyk hiszpa??ski, stopie?? 1
// Tomasz Sosin J??zyk hiszpa??ski, stopie?? 1
// Ryszard Bukowiecki J??zyk hiszpa??ski, stopie?? 2
// ??ukasz Ca??us J??zyk hiszpa??ski, stopie?? 2
// Miros??aw Chrobok J??zyk hiszpa??ski, stopie?? 2
// Janusz Kolczy??ski J??zyk hiszpa??ski, stopie?? 2
// Kazimierz Nawara J??zyk hiszpa??ski, stopie?? 2
// Robert Rafalski J??zyk hiszpa??ski, stopie?? 2
// Tomasz Sosin J??zyk hiszpa??ski, stopie?? 2