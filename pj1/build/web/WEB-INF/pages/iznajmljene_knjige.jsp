<%-- 
    Document   : iznajmljene_knjige
    Created on : 06-Feb-2020, 17:48:15
    Author     : Pumkin-duke
--%>

<%@page import="domen.Korisnik"%>
<%@page import="domen.Iznajmica"%>
<%@page import="java.util.List"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="java.util.Date"%>
<%@page import="domen.Knjiga"%>
<%@page import="controller.pl.ControllerPL"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <jsp:include page="../../header.jsp" />

    <form  id='IznajmiForma' action="FrontController" enctype="multipart/form-data" method="get" >
        <input type="hidden" name="action" value="iznajmiKnjiguAkcija" autocomplete="off" />
        <input type="hidden" id="iznajmiceComp" name="iznajmica" value=" " autocomplete="off" />

    </form>



    <div class="contentForma" style="display: inline-block !important; height: unset;" >


        <%
            if ( request.getParameter("knjigaZaIznajmljivanje")!=null && !request.getParameter("knjigaZaIznajmljivanje").isEmpty()) {
                Knjiga k = ControllerPL.getInstanca().vratiKnjigu(Integer.parseInt(request.getParameter("knjigaZaIznajmljivanje")));

                String slikaPutanja = "http://localhost:8084/pj1/images/" + k.getNaziv().replace(" ", "_").toLowerCase() + ".jpg";
                slikaPutanja = slikaPutanja.replace("č", "c").replace("š", "s").replace("ž", "z").replace("ć", "c").replace("đ", "dj");
                if (k.getKnjigaID() == 3) {

                    slikaPutanja = slikaPutanja.replace(".jpg", ".gif");
                }

                Date datum = new Date();
                SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
                String s = sdf.format(datum);

                long ltime = datum.getTime() + 7 * 24 * 60 * 60 * 1000;
                Date today7 = new Date(ltime);
                String max = sdf.format(today7);

        %>
        <div class='knjigaZaKupovinu'>
            <div>
                <img src=<%=slikaPutanja%>>
                <div class='datumIIme'>
                    <div>
                        <p>Datum od</p>
                        <input name=<%=k.getKnjigaID()%> type='date' class='datumOd' value="<%=s%>" min='<%=s%>' max='<%=max%>'>
                    </div>
                    <div>
                        <p>Datum do</p> 
                        <input name=<%=k.getKnjigaID()%> type='date' class='datumDo' value="<%=max%>" min='<%=s%>' >
                    </div>
                    <p class = 'imeKnjige' ><%=k.getNaziv()%> </p>
                </div>
               <!-- <p class = 'cena' ><%=k.getCena()%> din</p>-->
                <div class="buttonPolja">
                    <button id="zavrsiIznajmljivanje" class="buttonStn">Iznajmi</button>

                    <button id="ponistiIznajmljivanje" class="buttonStn" style="background: #db2424a3;">Poništi</button>
                </div>

            </div>
        </div>

        <%
            }
        %>


        <div style=" width: 100%;">
            <h1 style="padding-bottom:30px; margin-top:60px; border-bottom: 1px solid gray; text-align: center; width:60%;  margin-left: auto; margin-right: auto; ">Iznajmljene knjige</h1>
        </div>
        <%
            HttpSession sessionsa = request.getSession(false);
            Korisnik rk = (Korisnik) sessionsa.getAttribute("regularnikorisnik");
            List<Iznajmica> listaIznajmica = ControllerPL.getInstanca().vratiIznajmiceZaKor(rk);

            for (Iznajmica i : listaIznajmica) {
                Knjiga k = i.getKnjigaID();
                String slikaPutanja = "http://localhost:8084/pj1/images/" + k.getNaziv().replace(" ", "_").toLowerCase() + ".jpg";
                slikaPutanja = slikaPutanja.replace("č", "c").replace("š", "s").replace("ž", "z").replace("ć", "c").replace("đ", "dj");
                if (k.getKnjigaID() == 3) {

                    slikaPutanja = slikaPutanja.replace(".jpg", ".gif");
                }
                
                SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
               
        %>
        <div class='knjigaZaKupovinu'>
            <div><img src=<%=slikaPutanja%>>
                <div class='datumIIme'>
                    <div>
                        <p>Datum od</p>
                        <input name=<%=k.getKnjigaID()%> type='date' class='datumOd' readonly value="<%=sdf.format(i.getDatumIzdavanja())%>">
                    </div>
                    <div>
                        <p>Datum do</p> 
                        <input name=<%=k.getKnjigaID()%> type='date' class='datumDo' readonly value="<%=sdf.format(i.getDatumPovracaja())%>" >
                    </div>
                    <p class = 'imeKnjige' ><%=k.getNaziv()%> </p>
                </div>
            </div>
        </div>





        <%           }


        %>











    </div>


    <jsp:include page="../../footer.jsp" />

    <script>
        <%            if (request.getParameter("knjigaZaIznajmljivanje")!=null && !request.getParameter("knjigaZaIznajmljivanje").isEmpty()) {
        %>
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
        // var knjigaZaIznajmljivanje = "<%=request.getParameter("knjigaZaIznajmljivanje")%>";
        //alert(knjigaZaIznajmljivanje);


        var id_knjige =<%=request.getParameter("knjigaZaIznajmljivanje")%>;
        $("#ponistiIznajmljivanje").click(function () {

            document.getElementById("iznajmiKnjigu").submit();

        });


        $("#zavrsiIznajmljivanje").click(function () {



            // alert(vratiDatume());
            document.getElementById("iznajmiceComp").value = vratiDatume();

            //   alert( $("#datumOd").val());
            document.getElementById("IznajmiForma").submit();

        });


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
            /* var id = $(this).attr('name');
             for (var i = 0; i < listaDatuma.length; i++) {
             if (listaDatuma[i].id == id) {
             listaDatuma[i].datumOd = datumOd;
             listaDatuma[i].datumDo = datumDo;
             break;
             }
             }*/
        });

        $('.datumDo').change(function () {
            datumDo = new Date($(this).val());
            /*var id = $(this).attr('name');
             for (var i = 0; i < listaDatuma.length; i++) {
             if (listaDatuma[i].id == id) {
             // listaDatuma[i].datumOd = datumOd;
             listaDatuma[i].datumDo = datumDo;
             listaDatuma[i].datumOd = datumOd;
             
             break;
             }
             }*/
            // alert(listaDatuma[0].datumDo + " " + listaDatuma[0].datumOd);

        });


        function vratiDatume() {
            var iznajmice = "";

            datum = datumOd;
            var month = datum.getUTCMonth() + 1; //months from 1-12
            var day = datum.getUTCDate();
            var year = datum.getUTCFullYear();
            if (day < 10)
                day = "0" + day;
            if (month < 10)
                month = "0" + month;
            var datumOd1 = day + "-" + month + "-" + year;

            datum1 = datumDo;
            var month1 = datum1.getUTCMonth() + 1; //months from 1-12
            var day1 = datum1.getUTCDate();
            var year1 = datum1.getUTCFullYear();
            if (day1 < 10)
                day1 = "0" + day;
            if (month1 < 10)
                month1 = "0" + month1;
            var datumDo1 = day1 + "-" + month1 + "-" + year1;


            iznajmice = id_knjige + "," + datumOd1 + "," + datumDo1 + ",";


            return iznajmice;

        }
        <%
            }
        %>
    </script>


</html>
