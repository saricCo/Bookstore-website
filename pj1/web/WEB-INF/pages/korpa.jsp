<%-- 
    Document   : korpa
    Created on : Feb 11, 2019, 3:30:04 PM
    Author     : Pumpkin
--%>


<%@page import="domen.Korisnik"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="java.util.Date"%>
<%@page import="java.util.List"%>
<%@page import="controller.pl.ControllerPL"%>
<%@page import="domen.Knjiga"%>
<%@page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <jsp:include page="../../header.jsp" />

    <div class="contentForma" style="display: inline-block !important; height: unset;" >
        <div class="contentForma1"> </div>
        <div id="zaKupovinu"> </div>
        <div id="zaIzdavanje"> </div>
        <div id="ukupno"> </div>
        <div id="paypall">
            <script src="https://www.paypal.com/sdk/js?client-id=sb"></script>
            <script>paypal.Buttons().render('#paypall');</script>

        </div>

        <button id='sacuvajKnjiguButton' style="border-radius: 7px;" >Završi kupovinu!</button>





    </div>

    <form  id='napraviRacunID' action="FrontController" enctype="multipart/form-data" method="post" >
        <input type="hidden" name="action" value="napravi_racun" autocomplete="off" />
        <input type="hidden" id="idKnjiga" name="idKnjiga" value=" " autocomplete="off" />
        <input type="hidden" id="iznajmice" name="iznajmice" value=" " autocomplete="off" />
        <input type="hidden" id="korisnik" name="korisnik" value=" " autocomplete="off" />
        <input type="hidden" id="test4" type="submit"/>  
    </form>

    <jsp:include page="../../footer.jsp" />


    <script >

        var listaKnjigaZaKupovinu1 = "<%=request.getParameter("knjigeZaKupovinu")%>";
        var listaKnjigaZaKupovinu = listaKnjigaZaKupovinu1.split(',');
        var listaZaSlanje = [];
        var listaDatuma = [];
        <%
            List<Knjiga> listaKnjiga = ControllerPL.getInstanca().vratiKnjige();

        %>
        var suma = 0;
        onLoad();


        Date.prototype.toDateInputValue = (function () {
            var local = new Date(this);
            local.setMinutes(this.getMinutes() - this.getTimezoneOffset());
            return local.toJSON().slice(0, 10);
        });
        var datumDo = new Date();
        var datumOd = new Date();
        function onLoad() {

            if (listaKnjigaZaKupovinu.length != 0) {
                for (var i = 0; i < listaKnjigaZaKupovinu.length; i++) {
        <%  for (Knjiga k : listaKnjiga) {%>
                    if ("<%=k.getKnjigaID()%>" == listaKnjigaZaKupovinu[i]) {
                        suma +=<%=k.getCena()%>;
        <%

            String slikaPutanja = "http://localhost:8084/pj1/images/" + k.getNaziv().replace(" ", "_").toLowerCase() + ".jpg";
            slikaPutanja = slikaPutanja.replace("č", "c").replace("š", "s").replace("ž", "z").replace("ć", "c").replace("đ", "dj");
            if (k.getKnjigaID() == 3) {

                slikaPutanja = slikaPutanja.replace(".jpg", ".gif");
            }
        %>

                        if ('<%=k.getStatus()%>' == "ZA_PRODAJU")
                            $("#zaKupovinu").append(" <div class='knjigaZaKupovinu'><div><img src=<%=slikaPutanja%>> <p class = 'imeKnjige' ><%=k.getNaziv()%> </p> <p class = 'cena' ><%=k.getCena()%> din</p></div></div>");
                        else
                        {
        <%
            Date datum = new Date();
            SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
            String s = sdf.format(datum);

            long ltime = datum.getTime() + 7 * 24 * 60 * 60 * 1000;
            Date today7 = new Date(ltime);
            String max = sdf.format(today7);


        %>

                            $("#zaIzdavanje").append(" <div class='knjigaZaKupovinu'><div><img src=<%=slikaPutanja%>><div class='datumIIme'><div><p>Datum od</p><input name=<%=k.getKnjigaID()%> type='date' class='datumOd' min='<%=s%>' max='<%=max%>'></div><div><p>Datum do</p> <input name=<%=k.getKnjigaID()%> type='date' class='datumDo' min='<%=s%>' ></div><p class = 'imeKnjige' ><%=k.getNaziv()%> </p></div> <p class = 'cena' ><%=k.getCena()%> din</p></div></div>");

                            // document.getElementByClassName('datumOd').valueAsDate = new Date();
                            //$('.datumOd:last').val(new Date().toDateInputValue());
                            //alert(document.getElementsByClassName('datumOd').last().attr("type"));

                            var c = document.getElementsByClassName("datumOd");
                            var last_element = c[c.length - 1];
                            last_element.valueAsDate = new Date();

                            var c1 = document.getElementsByClassName("datumDo");
                            var last_element1 = c1[c1.length - 1];

                            var date = new Date();
                            date.setDate(date.getDate() + 7);
                            last_element1.valueAsDate = date;
                            datumDo = date;
                            datumOd = new Date();
                            listaDatuma.push({
                                'id':<%=k.getKnjigaID()%>,
                                'datumOd': datumOd,
                                'datumDo': datumDo,
                            });


                        }

                        listaZaSlanje.push({
                            'id': <%=k.getKnjigaID()%>,
                            'pisac': '<%=k.getPisac()%>',
                            'naziv': '<%=k.getNaziv()%>',
                            'izdavac': '<%=k.getIzdavac()%>',
                            'cena': <%=k.getCena()%>,
                            'opis': '<%=k.getOpis().replace("\'", "\"")%>',
                            'putanja': '<%=slikaPutanja%>',
                            'zanr': '<%=k.getZanrToString()%>',
                            'godinaIzdavanja': <%=k.getGodinaIzdavanja()%>,
                            'status': '<%=k.getStatus()%>',
                        });
                    }
        <%
            }

        %>
                }


                $("#ukupno").append(" <div style='display: inline-block;  min-height:50px;  width: 100%; margin-bottom:15px;'><div style='float:right; margin-right:5%;'><p class = 'imeKnjige' style='margin-left: 0; margin-right:30px; color:#3c948b; width: unset;'>Ukupno:</p><p  style='display: inline-block;  margin-top:15px; font-size:40px; color:black;'>" + suma + ".00 din</p></div> </div>");



                $('.datumOd').change(function () {
                    datumOd = new Date($(this).val());
                    var datum = datumOd;
                    datum.setDate(datum.getDate() + 7);

                    var month = datum.getUTCMonth() + 1; //months from 1-12
                    var day = datum.getUTCDate();
                    var year = datum.getUTCFullYear();
                    if (day < 10)
                        day = "0" + day;
                    if (month < 10)
                        month = "0" + month;
                    var datumMin = year + "-" + month + "-" + day;
                    $(this).parent().parent().find('.datumDo')[0].setAttribute('min', datumMin);
                    if (datum > datumDo) {

                        $(this).parent().parent().find('.datumDo')[0].valueAsDate = datum;
                        datumDo = datum;


                    }
                    var id = $(this).attr('name');
                    for (var i = 0; i < listaDatuma.length; i++) {
                        if (listaDatuma[i].id == id) {
                            listaDatuma[i].datumOd = datumOd;
                            listaDatuma[i].datumDo = datumDo;
                            break;
                        }
                    }
                });

                $('.datumDo').change(function () {
                    datumDo = new Date($(this).val());
                    var id = $(this).attr('name');
                    for (var i = 0; i < listaDatuma.length; i++) {
                        if (listaDatuma[i].id == id) {
                            // listaDatuma[i].datumOd = datumOd;
                            listaDatuma[i].datumDo = datumDo;
                            listaDatuma[i].datumOd = datumOd;

                            break;
                        }
                    }
                    // alert(listaDatuma[0].datumDo + " " + listaDatuma[0].datumOd);

                });
            }

        }

        function vratiDatume() {
            var iznajmice = "";
            for (var i = 0; i < listaDatuma.length; i++) {
                datum = listaDatuma[i].datumOd;
                var month = datum.getUTCMonth() + 1; //months from 1-12
                var day = datum.getUTCDate();
                var year = datum.getUTCFullYear();
                if (day < 10)
                    day = "0" + day;
                if (month < 10)
                    month = "0" + month;
                var datumOd1 = day + "-" + month + "-" + year;

                datum1 = listaDatuma[i].datumDo;
                var month1 = datum1.getUTCMonth() + 1; //months from 1-12
                var day1 = datum1.getUTCDate();
                var year1 = datum1.getUTCFullYear();
                if (day1 < 10)
                    day1 = "0" + day;
                if (month1 < 10)
                    month1 = "0" + month1;
                var datumDo1 = day1 + "-" + month1 + "-" + year1;


                iznajmice += listaDatuma[i].id + "," + datumOd1 + "," + datumDo1 + ",";

            }
            return iznajmice;

        }
        $('#sacuvajKnjiguButton').click(function ()
        {

        <%       Korisnik rk = (Korisnik) session.getAttribute("regularnikorisnik");
        %>


            document.getElementById("iznajmice").value = vratiDatume();
            document.getElementById("korisnik").value =<%=rk.getKorisnikID()%>;
            document.getElementById("idKnjiga").value = JSON.stringify(listaKnjigaZaKupovinu1);
            document.getElementById("napraviRacunID").submit();
            /* var xmlhttp = new XMLHttpRequest();
             xmlhttp.open("POST", "FrontController?action=napravi_racun");
             xmlhttp.setRequestHeader("Content-Type", "application/x-www-form-urlencoded;charset=UTF-8");
             var salji = "";
             for (var i = 0; i < listaZaSlanje.length; i++) {
             salji += listaZaSlanje[i].id + "";
             if (listaZaSlanje.length != i + 1)
             salji += ", ";
             }
             
             var form = new FormData();
             form.append("name", "");
             xmlhttp.send(JSON.stringify(salji));*/
        });

    </script>

</html>
