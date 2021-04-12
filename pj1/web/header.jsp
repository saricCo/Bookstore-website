<%-- 
    Document   : header
    Created on : Jan 30, 2019, 3:08:05 PM
    Author     : Pumpkin
--%>
<%@page import="domen.Korisnik"%>
<%@page import="domen.Admin"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@page import="java.io.File"%>
<%@page import="javax.swing.ImageIcon"%>
<%@page import="java.awt.Image"%>
<%@page import="domen.Knjiga"%>
<%@page import="java.util.List"%>
<%@page import="domen.Zanr"%>
<%@page import="controller.pl.ControllerPL"%>
<%@page contentType="text/html; charset=UTF-8; encoding=UTF-8" pageEncoding="UTF-8"%>

<!DOCTYPE html>
<html>

    <head>
        <link rel="stylesheet" type="text/css" href="css/main1.css" media="screen" >
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.6.3/css/font-awesome.min.css">

        <!--DEO ZA slidabar-->
        <link rel="stylesheet" href="css/slajder/normalize.css" />
        <link rel="stylesheet" href="css/slajder/ion.rangeSlider.css" />
        <link rel="stylesheet" href="css/slajder/ion.rangeSlider.skinFlat.css" />

        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <meta charset=UTF-8>

    </head>

    <body >
        <!--  <div style="position: absolute; z-index: 100; margin-left: 45%; margin-top: 200px;">
              <h4 id="poruka"></h4>
              <button>Close</button>
          </div>
        -->

        <div id="popup1" class="overlay" style="z-index: 100;">
            <div class="popup">
                <h2 id="poruka" style="padding-bottom: 10px;">Poruka!</h2>
                <a class="close" href="#">&times;</a>
                <div id="sub-poruka" class="content" style="padding-top:10px; border-top:1px solid gray">

                </div>
            </div>
        </div>
        <header id="header">

            <nav class="top">


                <%
                    HttpSession sessionsa = request.getSession(false);
                    Korisnik rk = (Korisnik) sessionsa.getAttribute("regularnikorisnik");
                    Admin a = (Admin) sessionsa.getAttribute("admin");

                    boolean loginovan = false;
                    boolean admin = false;
                    int idKorisnika = -1;
                    if (a != null) {
                        admin = true;
                    }
                    if (rk != null) {
                        idKorisnika = rk.getKorisnikID();
                        loginovan = true;
                    }

                %>

                <strong class="slogan"> Welcome to the best online selling bookstore! </strong>
                <%                    if (loginovan) {

                %>
                <form action="">
                    <input type="hidden" name="loginovani" id="loginovani" value="<%=rk.getUser().getImeIPrezime()%>" />
                </form>
                <%
                    }
                %>
                <ul class="right">
                    <%                        if (!loginovan && a == null) {
                    %>  <li class="login">
                        Da li ste član?
                        <a id="registerLogin" > Register / Login </a>
                    </li><%
                    } else if (a != null) {
                    %>
                    <li class="login">
                        <div style="cursor: pointer"> 
                            <div style="float:left;">
                                <strong style="color:black;"><%=a.getUser().getImeIPrezime()%> </strong>
                            </div>
                        </div>
                        <a class="item" style="" href="
                           <c:url value="FrontController">
                               <c:param name="action" value="logout"></c:param>
                           </c:url>">    Logout</a>
                    </li>
                    <%
                    } else {%>
                    <li class="login">
                        <div style="cursor: pointer"> 
                            <div style="float:left;">
                                <strong style="color:black;"><%=rk.getUser().getImeIPrezime()%> </strong>
                            </div>
                            <strong id="korpaBroj" style="color:black; float:left; margin-left:9px;">(0)</strong>
                            <img  src="http://localhost:8084/pj1/images/kolica4.png" style="width:26px; margin-top: 12px; ">
                        </div>
                        <a class="item" style="" href="
                           <c:url value="FrontController">
                               <c:param name="action" value="logout"></c:param>
                           </c:url>">    Logout</a>
                    </li>
                    <%

                        }
                    %>
                </ul>
            </nav>

            <nav class="main">

                <div>
                    <ul class="menu right">
                        <li><a href="
                               <c:url value="FrontController">
                                   <c:param name="action" value="index"></c:param>
                               </c:url>">Pocetna </a>  </li>
                            <% if (admin) {%>
                        <li ><a  href="
                                 <c:url value="FrontController">
                                     <c:param name="action" value="dodaj_knjigu"> </c:param>
                                 </c:url>">Dodaj knjigu </a>  </li>
                        <li ><a  href="
                                 <c:url value="FrontController">
                                     <c:param name="action" value="racuni"> </c:param>
                                 </c:url>">Racuni </a>  </li>
                            <%}
                                if (loginovan) {
                            %>

                        <li id="iznajmi01" >
                            <form id="iznajmiKnjigu"  action="FrontController" enctype="multipart/form-data" method="get" > 
                                <input type="hidden" name="action" value="iznajmljeneKnjige" autocomplete="off" />
                                <input type="hidden" name="knjigaZaIznajmljivanje" id="knjigaZaIznajmljivanje" value="" />
                                <button id="iznajmi" type="submit" forme="iznajmiKnjigu" name="action" value="iznajmljeneKnjige"/> Iznajmljene knjige
                            </form>

                        </li>

                        <li id="korpaLi">
                            <form id="forma1"  action="FrontController" enctype="multipart/form-data" method="post" >
                                <input type="hidden" name="action" value="korpa" autocomplete="off" />
                                <input type="hidden" name="knjigeZaKupovinu" id="knjigeZaKupovinu" value="" />
                                <button id="dodajKnjigu" type="submit" forme="forma1" name="action" value="Korpa"/> Korpa 
                            </form>

                        </li>
                        <%}%>


                        <li><a href="/">FAQ </a>  </li>
                        <li><a href="/">Kontakt </a>  </li>
                    </ul>
                </div>
            </nav>

            <nav class="search">
                <div class="left">
                    <ul class="menu">


                        <li   id="dropdown0"  data-filter="category">
                            <div  id="kupovina" style="position: relative; float: left;">
                                <span style="float:left;">
                                    Kupovina
                                </span>

                            </div>
                            <div  id="prvi" >  </div>
                            <div id="iznajmljivanje" style="float:left;">
                                <span>Izdavanje</span>

                            </div>

                        </li>
                        <li class="dropdown"  id="dropdown1"  data-filter="category">
                            <span>
                                Godina izdavanja
                            </span>

                        </li>
                        <li class="dropdown" id="dropdown2" data-filter="category">
                            <span>
                                Zanr
                            </span>
                        </li>
                        <li class="dropdown" id="dropdown3"  data-filter="category">
                            <span>
                                Cena
                            </span>
                        </li>



                    </ul>
                </div>



                <div class="pretraga">


                    <input id="pretraga3" type="text" spellcheck="false" autocomplete="off"  class="text">
                    <button type="submit" name="bt_search" class="bt-search" id="bt-search"> </button>




                    <span class="bt-search" style="pointer-events: none;">
                        <i id="icon" class="fa fa-search" aria-hidden="true"></i>
                    </span>


                    <div id="sugestije"></div>

                </div>









                <br>


                <div class="dropdownMenu" id="dropdownMenu1" >


                    <div style="padding:15px 20px 15px 20px; width:350px">
                        <input type="text" id="range2" value="" name="range" />
                    </div>

                    <div id="border" >

                    </div>

                </div>
                <%
                    List<Zanr> lista = ControllerPL.getInstanca().vratiZanr();

                %>
                <div class="dropdownMenu" id="dropdownMenu2" >
                    <%                       for (Zanr z : lista) {
                            String ime = "ime1" + z.getZanrID();
                            String naziv = z.getNaziv();
                    %>
                    <div id=<%=ime%>>
                        <div >
                            <strong><%=naziv%></strong>
                        </div>

                    </div>
                    <%
                        }
                    %>



                    <div id="border" >
                    </div>
                </div>



                <div class="dropdownMenu" id="dropdownMenu3">

                    <div style="padding:15px 20px 15px 20px;">
                        <input type="text" id="range1" value="" name="range" />
                    </div>
                </div>


            </nav>
        </header>


        <div id="reglogGlavna" style="display:none;">



            <div id="book_bacgroundCover">   </div>
            <img id="book_background" src="http://localhost:8084/pj1/images/book_background.jpg">

            <div id="reglog">

                <div class="form-style-5" id="reglogID" >


                    <div style="margin-right: 65px; float: right; width: 55%; display: inline-flex;"> 
                        <input id="login" style="background-color:#3b4745" type="button" class="loginRegistracija" value="LogIn"/>  
                        <input id="register" class="loginRegistracija" type="button"  value="Registracija"/>  
                    </div>
                    <div style="width: 100%; border-top: 1.5px solid #3b4745;  float:right;"> </div>

                    <form  id="formaLogin" action="FrontController" enctype="multipart/form-data" method="post" >
                        <input type="hidden" name="action" value="login"  />
                        <table id="tableForma">

                            <div style="float:left !important; width:100% !important;" class="field"><p id="uspesnaRegistracija" style="color:#1d7d24; font-size: 22px; text-align: center; vertical-align: middle;"></p> </div>

                            <div style="margin-top:100px !important;" class="field">
                                <input type="text" name="username" size="80" placeholder="Unesi username" autocomplete="off" required oninvalid="this.setCustomValidity('Morate uneti username')" oninput="this.setCustomValidity('')"/>
                            </div>

                            <div class="field">
                                <input id="password" type="password" name="password" size="80" placeholder="Unesi password" autocomplete="off" required oninvalid="this.setCustomValidity('Morate uneti password')" oninput="this.setCustomValidity('')"/>
                            </div>



                            <div style="float:left !important; margin-top:90px;" class="field">

                                <input  class="nazad" type="button" value="Nazad"/>  
                            </div>

                            <div class="field">

                                <input style="margin-top:60px;" type="submit" value="Login"/>  
                            </div>

                        </table>
                    </form> 

                    <form  id="formaRegistracija" style="display:none;" action="FrontController" enctype="multipart/form-data" method="post" >
                        <input type="hidden" name="action" value="registracija" autocomplete="off" />
                        <table id="tableForma">



                            <div class="field"><p id="greskaRegistracija" style="color: #d93d3d; font-size: 17px;"></p> </div>

                            <div class="field">
                                <input type="text" name="imeIPrezime" size="80" placeholder="Unesite vaše ime i prezime" required oninvalid="this.setCustomValidity('Morate uneti vaše ime i prezime')" oninput="this.setCustomValidity('')" autocomplete="off"/>
                            </div>

                            <div class="field">
                                <input type="text" name="username" size="80" placeholder="Unesite username" required oninvalid="this.setCustomValidity('Obavezno polje')" oninput="this.setCustomValidity('')" autocomplete="off"/>
                            </div>

                            <div class="field">
                                <input type="password" id="pass1" name="password" size="80" placeholder="Unesite password" required oninvalid="this.setCustomValidity('Obavezno polje')" oninput="this.setCustomValidity('')" autocomplete="off"/>
                            </div>

                            <div class="field">
                                <input  type="password" id="pass2"  name="password2" size="80" placeholder="Ponovo unesite password" required oninvalid="this.setCustomValidity('Obavezno polje')" oninput="this.setCustomValidity('')" autocomplete="off"/>
                            </div>

                            <div class="field">
                                <input type="text" name="email" size="80" placeholder="Unesite vaš email"  required oninvalid="this.setCustomValidity('Obavezno polje')" oninput="this.setCustomValidity('')" autocomplete="off" />
                            </div>
                            <div class="field">
                                <input  type="text" name="eRacun" size="80" placeholder="Unesite vaš elektronski račun"  required oninvalid="this.setCustomValidity('Obavezno polje')" oninput="this.setCustomValidity('')" autocomplete="off"/>
                            </div>
                            <div style="width: 100%;" class="field">
                                <strong>Unesite datum rođenja  </strong>
                                <input  type="date" name="datumRodjenja" size="100"  autocomplete="off"/>
                            </div>



                            <div style="float:left !important; margin-top:90px;" class="field">

                                <input  class="nazad" type="button" value="Nazad"/>  
                            </div>

                            <div class="field">

                                <input style="margin-top:60px;" id="submitRegistracija" type="button" value="Register"/>  
                            </div>

                        </table>
                    </form> 

                </div>


            </div>
        </div>

    </body>
    <script>


        var loginovanKorisnik =<%=loginovan%>;
        var idKorisnika =<%=idKorisnika%>;
        var loginovanAdmin =<%=admin%>



    </script>
</html>
