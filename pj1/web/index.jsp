<%-- 
    Document   : index
    Created on : Jan 28, 2019, 2:05:39 PM
    Author     : Pumpkin
--%>


<%@page import="java.util.ArrayList"%>
<%@page import="java.util.LinkedList"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@page import="java.io.File"%>
<%@page import="javax.swing.ImageIcon"%>
<%@page import="java.awt.Image"%>
<%@page import="domen.Knjiga"%>
<%@page import="java.util.List"%>
<%@page import="domen.Zanr"%>
<%@page import="controller.pl.ControllerPL"%>
<%@page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>

    <jsp:include page="header.jsp" />


    <br>
    <content>

        <div class="kolekcijaKnjiga">

        </div>
        <!--
                <div>
                    <div id="komentari">
                        <br>
                        <br>
                        <br>
                        <textarea id="komentar" type="text" placeholder="Ostavite vaš utisak ili mišljenje o telefonu"></textarea>
                        <input id="potpis" type="text" placeholder="Potpis"> Ili se prijavite putem
                        <input id="posalji" type="submit" value="Pošalji" />
                        <br>
                        <br>
                        <br>
                        <br>
                        <h2>Komentari: </h2>
                        <div style="border-bottom: 15px;" id="komentariPrikaz"> 
                        </div>
                    </div>
                </div>
        
        
        -->

    </content>


    <form  id="formaObrisiKnjigu" action="FrontController" enctype="multipart/form-data" method="get" >
        <input type="hidden" name="action" value="obrisi_knjigu" autocomplete="off" />
        <input id="knjigaZaBrisanje" type="hidden" name="knjigaID"/>
    </form>


    <div  id="izmenaKnjigeProzor">
        <div id="forma" style="width:96% !important; margin-left:2% !important; padding:0 !important; border:0 !important;" class="form-style-5">
            <form  id="formaIzmeniKnjigu" action="FrontController" enctype="multipart/form-data" method="get" >
                <input type="hidden" name="action" value="izmeni_knjigu" autocomplete="off" />
                <table id="tableForma">
                    <input type="hidden" name="knjigaID" id="knjigaID"/>
                    <input id="namena1" type="hidden"  name="namena1" value="ZA_PRODAJU" />

                    <div class="field">
                        <input type="text" id="nazivKnjige" name="nazivKnjige" size="80" placeholder="Unesi naziv knjige" autocomplete="off"/>
                    </div>

                    <div class="field">
                        <input id="autorIzmena" type="text" name="pisac"  placeholder="Unesi ime i prezime pisca" autocomplete="off"/>
                    </div>


                    <div class="field">
                        <input id="cena" type="text" name="cena" size="80" placeholder="Unesi cenu" autocomplete="off"/>
                    </div>
                    <div class="file-upload">
                        <div class="file-select">
                            <div class="file-select-button" id="fileName">Choose image</div>
                            <div class="file-select-name" id="noFile">Unesi sliku...</div> 
                            <input  type="file"  name="photo" id="chooseFile"  /> 

                        </div>
                    </div>
                    <div style="width: 94%; height:115px;" class="field">
                        <textarea id="opis" style=" height:100%; width: 90% !important; float:right;" name="opis" placeholder="Unesi opis za knjigu" ></textarea>
                    </div> 
                    <div class="field">
                        <input id="izdavac" type="text" name="nazivIzdavaca" size="80" placeholder="Unesi izdavača" autocomplete="off"/>
                    </div>
                    <div class="field">
                        <input type="text" id="godinaIzdanja" name="godinaIzdanja" size="80" placeholder="Unesi godinu štampanja" autocomplete="off"/>
                    </div>
                    <div class="field">
                        <input type="text" id="brKopija" name="brojZaUnos" size="80" placeholder="Unesi broj kopija" autocomplete="off"/>
                    </div>

                    <div class="field">
                        <input type="text" id="zanrovi" name="zanr" size="80" placeholder="Zanr" autocomplete="off"/>
                    </div>
                    <div class="field" style="width: 100%; margin-left: 7% !important;float: left;">
                        <input id="namenaKnjige" type="checkbox" value="ZA_PRODAJU" />
                        <p style="float:left;font-family: Georgia, 'Times New Roman', Times, serif; cursor:default; color:  #8a97a0; ">Za prodaju</p>
                    </div>



                    <div id="nazadIzmenaKnjige" style="float:left !important; margin-top:30px;">
                        <input id="saveKnjiga" type="button" value="Nazad"/>  
                    </div>

                    <div class="field" style="width:auto !important; min-width:15% !important;">

                        <input style="float:right;" id="izmeniKnjiguBtn" type="button" value="Izmeni"/>  
                    </div>


                </table>
            </form> 
        </div>


    </div>
    <div id="backgroundBlur" style="display:none; position:fixed; left:0; top:0; width:100%; height: 100%; z-index:15; background-color: #434a4d; opacity: 0.5;">  </div>










    <jsp:include page="footer.jsp" />

    <script>







        <%
            List<Knjiga> listaKnjiga = ControllerPL.getInstanca().vratiKnjige();

        %>
        var blockNumbers = 6;
        var lista = [];
        var listaNova = [];
        ucitajListu();
        ucitajKnjige(lista);
        function ucitajListu() {

        <%            for (Knjiga k : listaKnjiga) {
                if (k.getStanjeNaLageru() > 0) {
                    String slikaPutanja = " http://localhost:8084/pj1/images/" + k.getNaziv().replace(" ", "_").toLowerCase() + ".jpg";
                    slikaPutanja = slikaPutanja.replace("č", "c").replace("š", "s").replace("ž", "z").replace("ć", "c").replace("đ", "dj");

                    if (k.getKnjigaID() == 3) {

                        slikaPutanja = slikaPutanja.replace(".jpg", ".gif");
                    }
        %>

            lista.push({
                'id': <%=k.getKnjigaID()%>,
                'pisac': '<%=k.getPisac()%>',
                'naziv': '<%=k.getNaziv()%>',
                'izdavac': '<%=k.getIzdavac()%>',
                'cena': <%=k.getCena()%>,
                'opis': '<%=k.getOpis().replace("\'", "\"")%>',
                'putanja': '<%=slikaPutanja%>',
                'zanr': '<%=k.getZanrToString()%>',
                'godinaIzdavanja': <%=k.getGodinaIzdavanja()%>,
                'brKopija':<%=k.getStanjeNaLageru()%>,
                'status': '<%=k.getStatus()%>'
            });
        <%              }

            }%>
        }


        function obrisiKnjigu() {
            $("#knjigaZaBrisanje").val($("#obrisiKnjigu").parent().parent().attr('name'));
            $("#formaObrisiKnjigu").submit();
        }

        function ucitajKnjige(lista1) {
            $(".knjiga").remove();

            for (var i = 0; i < lista1.length && i < blockNumbers; i++)
            {
                
                    $(".kolekcijaKnjiga").append("<div class='knjiga'  name=" + lista1[i].id + "><img style='height:450px; margin-right: 7px; float:left; ' src=" + lista1[i].putanja + "><div class='sadrzajKnjige'><div class='sadrzajOpis'><p>" + lista1[i].opis + "</p></div><div style='height:40%'><br><strong>Autor:<br>" + lista1[i].pisac + "  </strong><br><br><strong> Zanr:  " + lista1[i].zanr + " </strong><br><br><strong> Cena: " + lista1[i].cena + "  </strong><br></div></div></div>");
                
            }
            $(".knjiga").hover(function () {
                if (loginovanKorisnik) {
                    for (var i = 0; i < lista.length; i++) {
                        if (lista[i].id == $(this).attr("name")) {
                            if (lista[i].status == "ZA_PRODAJU") {
                                // alert(lista[i].status);
                                $(this).append("<div id='tool'> <div  id='dodajUKopru' onclick='dodajKnjiguNaRacun()' ><p >Dodaj u   </p><img src='http://localhost:8084/pj1/images/kolica4.png' style='width:30px; margin-right: 8px;'> </div>");
                                break;
                            } else {
                                $(this).append("<div id='tool'> <div  id='dodajUKopru' onclick='dodajKnjiguNaIznajmicu()' ><p >Iznajmi  </p><img src='http://localhost:8084/pj1/images/kolica4.png' style='width:30px; margin-right: 8px;'> </div>");
                                break;
                            }
                        }
                    }


                }

                if (loginovanAdmin) {
                    $(this).append("<div id='tool'> <div  id='obrisiKnjigu' onclick='obrisiKnjigu(this)' ><p >Obriši </p></div><div id='izmeniKnjigu' ><p >Izmeni</p></div></div>");
                }

                $("#chooseFile").change(function () {
                    var filename = $("#chooseFile").val();
                    if (/^\s*$/.test(filename)) {
                        $(".file-upload").removeClass('active');
                        $("#noFile").text("No file chosen...");
                    } else {
                        $(".file-upload").addClass('active');
                        $("#noFile").text(filename.replace("C:\\fakepath\\", ""));
                    }

                    readURL(this);
                });
                $('#izmeniKnjigu').click(function () {

                    // alert(lista.length);

                    var knjigaBr = $(this).parent().parent().attr('name');
                    for (var i = 0; i < lista.length; i++) {
                        if (lista[i].id == knjigaBr)
                        {

                            $("#knjigaID").val(lista[i].id);
                            $("#nazivKnjige").val(lista[i].naziv);
                            $("#autorIzmena").val(lista[i].pisac);
                            $("#cena").val(lista[i].cena);
                            $("#noFile").text((lista[i].naziv).replace(/\ /g, "_") + ".jpg");
                            $("#opis").val(lista[i].opis);
                            $("#izdavac").val(lista[i].izdavac);
                            $("#godinaIzdanja").val(lista[i].godinaIzdavanja);
                            $("#zanrovi").val(lista[i].zanr);
                            $("#brKopija").val(lista[i].brKopija);
                            $("#namenaKnjige").val(lista[i].status);
                            if (lista[i].status == "ZA_PRODAJU")
                            {
                                $("#namena1").val("ZA_PRODAJU");
                                $('#namenaKnjige').prop('checked', true);

                            } else {
                                $('#namenaKnjige').prop('checked', false);
                                $("#namena1").val("ZA_IZNAJMLJIVANJE");
                            }
                        }
                    }
                    $("#izmenaKnjigeProzor").css("display", "block");
                    $("#backgroundBlur").css("display", "block");
                    $('html, body').animate({scrollTop: 0}, 'slow');
                });
                $('#nazadIzmenaKnjige').click(function () {

                    $("#izmenaKnjigeProzor").css("display", "none");
                    $("#backgroundBlur").css("display", "none");
                });
            }
            , function () {
                $("#tool").remove();
            });




        }

        $('#izmeniKnjiguBtn').click(function () {

            var cena = document.getElementById("cena").value;
            var godina = document.getElementById("godinaIzdanja").value;
            var brKopija = document.getElementById("brKopija").value;
            var unetiZanrovi = (document.getElementById("zanrovi").value).split(", ");
            var zanrovi = [];
        <%

            List<Zanr> lista1 = ControllerPL.getInstanca().vratiZanr();
            for (Zanr z : lista1) {
        %>
            zanrovi.push("<%=z.getNaziv()%>");
        <%

            }
        %>

            for (var i = 0; i < unetiZanrovi.length; i++) {
                var dobar = false;
                for (var j = 0; j < zanrovi.length; j++) {
                    if (unetiZanrovi[i] == zanrovi[j]) {
                        dobar = true;
                        break;
                    }

                }
                if (!dobar) {
                    alert("Ne postoji zanr sa nazivom: " + unetiZanrovi[i]);
                    return;
                }
            }

            if (isNaN(cena) || isNaN(godina) || isNaN(brKopija)) {
                alert("Cena, godina i broj kopija moraju biti brojevi!");
                return;
            } else {
                document.getElementById("formaIzmeniKnjigu").submit();
            }

        }
        );


        $("#namenaKnjige").click(function () {
            if ($(this).prop("checked")) {
                $(this).val("ZA_PRODAJU");

                $("#namena1").val("ZA_PRODAJU");
            } else {
                $(this).val("ZA_IZNAJMLJIVANJE");
                $("#namena1").val("ZA_IZNAJMLJIVANJE");
            }
        });

        var knjigeZaKupovinu = [];
        function dodajKnjiguNaRacun() {


            for (var i = 0; i < lista.length; i++) {
                var id = $('#tool').parent().attr('name');
                if (lista[i].id == id) {
                    knjigeZaKupovinu.push(lista[i].id);
                    break;
                }


            }
            document.getElementById('knjigeZaKupovinu').value = knjigeZaKupovinu;
            $("#korpaBroj").html("(" + knjigeZaKupovinu.length + ")");
        }

        function dodajKnjiguNaIznajmicu() {



            var id = $('#tool').parent().attr('name');




            document.getElementById('knjigaZaIznajmljivanje').value = id;
            document.getElementById("iznajmiKnjigu").submit();

        }





        $('#korpaID').click(function () {
            $("#knjigeZaKupovinu").submit();
        });
        var izabraniZanrovi = [];
        $('#dropdownMenu2 div div').click(function () {

            var zanr = $(this).find('strong').html();
            if (izabraniZanrovi.includes(zanr)) {

                var index = izabraniZanrovi.indexOf(zanr);
                if (index > -1) {

                    izabraniZanrovi.splice(index, 1);
                }
            } else {
                izabraniZanrovi.push(zanr);
            }

            if (izabraniZanrovi.length == 0) {
                kriterijumi = kriterijumi.replace("zanr", "");
                if (kriterijumi.length > 3)
                    vratiKnjigePoKriterijumu("");
                else
                    ucitajKnjige(lista);
            } else
                vratiKnjigePoKriterijumu("zanr");
        });


        $("#dropdown0").click(function () {

            vratiKnjigePoKriterijumu("prodKupi");

        });
        function vratiKnjigePoKriterijumu(akcija) {
            blockNumbers = 6;
            if (!kriterijumi.includes(akcija))
                kriterijumi += akcija;
            listaNova = [];
            var unos = $('#pretraga3').val().toLowerCase();
            if (kriterijumi == "")
            {
                ucitajKnjige(lista);
                return;
            }

            for (var i = 0; i < lista.length; i++)
            { // treba da se napravi samo ifovi da se vidi koji trebaju da se uzmu uz obzir ako je if true ta neka prica
                var ideUlistu = false;

                if (kriterijumi.includes("cena")) {
                    var slider1 = $("#range1").data("ionRangeSlider");
                    if (lista[i].cena > slider1.result.from && lista[i].cena < slider1.result.to)
                    {
                        ideUlistu = true;
                    } else {
                        continue;
                    }

                }
                if (kriterijumi.includes("prodKupi")) {


                    if (lista[i].status == status)
                    {
                        ideUlistu = true;
                    } else
                        continue;

                }
                if (kriterijumi.includes("zanr")) {
                    //  alert(izabraniZanrovi.join(" "));
                    if (izabraniZanrovi.length > 0) {
                        var moze = false;

                        for (var j = 0; j < izabraniZanrovi.length; j++) {

                            if (!((lista[i].zanr.toLowerCase()).includes(izabraniZanrovi[j].toLowerCase()))) {
                                ideUlistu = false;
                                break;
                            }
                            ideUlistu = true;


                        }


                    } else {

                        ucitajKnjige(lista);
                        return;
                    }


                }
                if (kriterijumi.includes("godinaIzdavanja")) {
                    if (lista[i].godinaIzdavanja >= slider.result.from && lista[i].godinaIzdavanja <= slider.result.to)
                    {
                        ideUlistu = true;
                    } else {

                        continue;
                    }
                }
                if (kriterijumi.includes("pretraga")) {
                    if ((lista[i].pisac.toLowerCase()).includes(unos) || (lista[i].naziv.toLowerCase()).includes(unos) || (lista[i].izdavac.toLowerCase()).includes(unos) || (lista[i].zanr.toLowerCase()).includes(unos)) {
                        ideUlistu = true;
                    } else {
                        ideUlistu = false;
                        continue;
                    }

                }

                if (ideUlistu) {
                    listaNova.push({
                        'id': lista[i].id,
                        'pisac': lista[i].pisac,
                        'naziv': lista[i].naziv,
                        'izdavac': lista[i].izdavac,
                        'cena': lista[i].cena,
                        'opis': lista[i].opis,
                        'putanja': lista[i].putanja,
                        'zanr': lista[i].zanr,
                        'godinaIzdavanja': lista[i].godinaIzdavanja,
                        'status': lista[i].status
                    });
                }
            }
            ucitajKnjige(listaNova);
        }


        $('#bt-search').click(function () {
            vratiKnjigePoKriterijumu("pretraga");
        });
        $(window).scroll(function () {
            if ($(window).scrollTop() + $(window).height() - $(document).height() > -1) {

                blockNumbers += 6;
                if (listaNova.length == 0)
                    ucitajKnjige(lista);
                else
                    ucitajKnjige(listaNova);
            }

        });




    </script>


