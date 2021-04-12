<%-- 
    Document   : racuni
    Created on : Mar 24, 2019, 9:27:03 PM
    Author     : Pumpkin
--%>

<%@page import="java.util.Collection"%>
<%@page import="domen.Stavkaracuna"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="controller.pl.ControllerPL"%>
<%@page import="java.util.List"%>
<%@page import="java.util.Date"%>


<%@page import="domen.Racun"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <jsp:include page="../../header.jsp" />

    <div class="contentForma" style="width: 90% !important; margin-left:4% !important;"  >


        <div style="width:27%; float:left;">

            <div style="width: 90%; float:left; margin:40px 0 20px 10px">
                <div style="background:#4f54ed08; padding: 0 5% 0 5%; width: 90%;">
                    <select id = "search-select" class="select-css ">
                        <option value = "1">Kupac</option>
                        <option value = "2">Vreme</option>
                        <option value = "3">Popust</option>
                        <option value = "4">Broj knjiga</option>
                        <option value = "5">Iznos</option>
                        <option value="7">Knjiga</option>

                    </select>
                    <div id="search-input" style="border-bottom: 1px solid #787878;">
                        <input placeholder='Unesi naziv kupca' type="text">
                    </div>

                    <br>
                    <button id="search-tag" style="margin-top:10px;">Pretrazi</button>
                </div>
                <div id="tagWall" style="float:left; border-bottom: 1px solid #939393; padding-bottom: 10px;">



                   
                </div>
                 <p id="brRezultata" style="cursor:default; clear: both; float: right;  margin-top: 15px;"></p>
            </div>



        </div>
        <div>


            <table id="detaljiRacun1">
                <tbody id="neDiraj">
                    <tr id="tableHeader">
                        <th>Kupac</th>
                        <th>Vreme</th>
                        <th>Popust</th>
                        <th>Broj knjiga</th>
                        <th>Iznos</th>
                    </tr>
                </tbody>


            </table>
        </div>


        <div id='bgIzmeni' style="position: fixed; width: 100%; height: 100%; opacity:0.5; top:0; left:0;background: white; display: none;"> </div>
        <div id='izmeniRacun' style="position: fixed; width: 70%; height:500px; left:10%; top:100px; display:none;">
            <div id='izmenaRacuna'>
                <div id="forma" style="width:100% !important; margin:0 !important; height:100% !important; padding:0 !important; border:0 !important;" class="form-style-5">
                    <form  id="formaIzmeniRacun" action="FrontController" enctype="multipart/form-data" method="get" >
                        <input type="hidden" name="action" value="izmeni_racun" autocomplete="off" />
                        <table id="tableForma">
                            <input type="hidden" name="racunID" id="racunID"/>


                            <div class="field1">
                                <label for='kupacIme'>Kupac</label>
                                <input id="kupacIme" type="text" name="kupacIme"  readonly />
                            </div>

                            <div class="field1">
                                <label for='datumRacun'>Datum kupovine</label>
                                <input type="date" id="datumRacun" name="datumRacun" size="80" autocomplete="off"/>
                            </div>

                            <div class="field1">
                                <label for='popustIzmena'>Popust</label>
                                <input id="popustIzmena" type="text" name="popust" autocomplete="off"/>
                            </div>


                            <div class="field1">
                                <label for='iznosIzmena'>Iznos</label>
                                <input id="iznosIzmena" type="text" name="iznos" autocomplete="off" readonly />
                            </div>



                        </table>
                    </form>
                    <div id='divTblSR' style='float:left; width: 55%;'>

                        <table id='tabelaStavkaRacuna' style=" height: 250px;">
                            <tr id='tableHeader'>
                                <th> Redni broj</th>
                                <th> Knjiga</th>
                                <th> Cena</th>

                            </tr>

                        </table>
                    </div>

                    <div id="nazadIzmenaKnjige" style="float:left !important; margin-top:30px;">
                        <input id="nazadBtn" style='margin-left:10%;' type="button" value="Nazad"/>  
                    </div>

                    <div class="field1" style="float:right; width:auto !important; min-width:15% !important;">

                        <input style="float:right; margin-right:10%;" id="izmeniRacunBtn" type="button" value="Izmeni"/>  
                    </div>
                </div>

            </div>

        </div>


    </div>




    <form  id="formaRacunZaBrisanje" action="FrontController" enctype="multipart/form-data" method="get" >
        <input type="hidden" name="action" value="obrisi_racun" autocomplete="off" />
        <input id="racunZaBrisanje" type="hidden" name="racunID"/>
    </form>

    <jsp:include page="../../footer.jsp" />


    <script>

        var setMinDate;
        var setMaxDate;
        var setMinPopust = 0;
        var setMaxPopust = 0;
        var setMinIznos = 0;
        var setMaxIznos = 0;
        var setMinBrKnjiga = 0;
        var setMaxBrKnjiga = 0;
        var kupci = [];
        var pisci = [];
        var knjige = [];
        var defMinDate, defMaxDate, defMinPopust, defMaxPopust, defMinIznos, defMaxIznos, defMinBrKnjiga, defMaxBrKnjiga;
        $('#search-select').on('change', function () {
            //alert(this.value);
            if (this.value == "1") {

                $("#search-input").empty();
                $("#search-input").append("<input placeholder='Unesi naziv kupca' type='text'>");
            } else if (this.value == "2") {
                // alert(najranijiRacun);
                $("#search-input").empty();
                $("#search-input").append("<label>Datum posle</label><input id='najranijiDatum' style='margin-bottom:15px;' type='date' min=" + setMinDate + " value=" + setMinDate + "> <label>Datum pre</label><input id='najkasnijiDatum' type='date' max=" + setMaxDate + "  value=" + setMaxDate + ">");
                // $('#najranijiDatum').val(najranijiRacun);
                // $('#najkasnijiDatum').val(najkasnijiRacun);
            } else if (this.value == "3") {
                $("#search-input").empty();
                $("#search-input").append("<label>Popust veći od</label><input type='text' value=" + setMinPopust + ">  <label>Popust manji od </label><input type='text' value=" + setMaxPopust + " > ");
            } else if (this.value == "4") {
                $("#search-input").empty();
                $("#search-input").append("<label>Broj artikala veći od</label><input type='text' value=" + setMinBrKnjiga + ">  <label>Broj artikala manji od</label><input type='text' value=" + setMaxBrKnjiga + "> ");

            } else if (this.value == "5") {
                $("#search-input").empty();
                $("#search-input").append("<label>Iznos veći od</label><input type='text' value=" + setMinIznos + ">  <label>Iznos manji od</label><input type='text' value=" + setMaxIznos + " > ");

            } else if (this.value == "7") {
                $("#search-input").empty();
                $("#search-input").append("<input placeholder='Unesi naziv knjige' type='text'>");
            }
        });

        function obnoviRacune() {
            trenutnaLista = [];
            $("#detaljiRacun1").children().not('#neDiraj').remove();

            //    alert(listaRacun[5].popust);
            for (var i = 0; i < listaRacun.length; i++) {


                if (parseFloat(listaRacun[i].iznos) >= setMinIznos && parseFloat(listaRacun[i].iznos) <= setMaxIznos) {
                    //alert(15);
                    if (parseFloat(listaRacun[i].popust) >= setMinPopust && parseFloat(listaRacun[i].popust) <= setMaxPopust)
                    {
                        var broj = (listaRacun[i].stavke.split("/").length - 1);

                        if (broj >= setMinBrKnjiga && broj <= setMaxBrKnjiga) {
                            var datum = listaRacun[i].vreme.split('-').reverse().join('-');
                            // alert(datum);
                            if (Date.parse(datum) >= Date.parse(setMinDate) && Date.parse(datum) <= Date.parse(setMaxDate)) {


                                var mozeKnjige = false;
                                //alert(kupci[0]);
                                if (knjige.length > 0) {
                                    for (var j = 0; j < knjige.length; j++) {
                                        //alert(knjige[j]);
                                        if (listaRacun[i].stavke.indexOf(knjige[j]) >= 0) {
                                            //  alert(listaRacun[i].stavke.indexOf(knjige[j]));
                                            mozeKnjige = true;
                                            break;
                                        }
                                    }
                                }
                                var mozeKupci = false;
                                if (kupci.length > 0) {
                                    for (var j = 0; j < kupci.length; j++) {
                                        //alert(knjige[j]);
                                        if (listaRacun[i].kupac.indexOf(kupci[j]) >= 0) {
                                            //  alert(listaRacun[i].stavke.indexOf(knjige[j]));
                                            mozeKupci = true;
                                            break;
                                        }
                                    }

                                }

                                //  alert(knjige.length);

                                if ((mozeKnjige || knjige.length == 0) && (mozeKupci || kupci.length == 0)) {

                                    dodajRacuneUTabelu(listaRacun[i]);
                                    trenutnaLista.push(listaRacun[i]);
                                }


                            }


                        }



                    }
                }

            }
            
            
           
            $("#brRezultata").text( "Nađeno je " + trenutnaLista.length+ " računa");

        }


        $("#search-tag").click(function () {
            var prvi;
            var drugi;
            var postavljen = false;
            $("#search-input").find("input").each(function () {
                if (!postavljen) {
                    postavljen = true;
                    prvi = $(this).val();
                } else {
                    drugi = $(this).val();
                }

                //console.log($(this).val());

            });
            /* $('#tagWall').children('.tag').each(function () {
             alert($(this).attr("name"));
             });*/
            var selected = $('#search-select').val();
            if (prvi != "") {


                if (selected == "1") {
                    if (!kupci.includes(prvi)) {
                        kupci.push(prvi);
                        $("#tagWall").append(' <div class="tag" name="kupac" style="border:1px solid black; border-radius: 10px; padding: 2px 8px 2px 8px;"><p>' + prvi + '  <i class="fa fa-times-circle"  style="float:right;" aria-hidden="true"></i></p></div>');
                    }
                } else if (selected == "2") {
                    // alert($("#tagWall").children('div[name="minDate"]'));
                    setMinDate = prvi;
                    setMaxDate = drugi;
                    $('#tagWall').children('.tag').each(function () {
                        //alert($(this).attr("name"));
                        if ($(this).attr("name") == "minDate" || $(this).attr("name") == "maxDate") {
                            $(this).remove();

                        }
                    });
                    if (defMinDate != setMinDate) {
                        $("#tagWall").append(' <div class="tag" name="minDate" style="border:1px solid black; border-radius: 10px; padding: 2px 8px 2px 8px;"><p>Datum od ' + prvi + '  <i class="fa fa-times-circle" style="float:right;" aria-hidden="true"></i></p></div>');

                    }
                    if (defMaxDate != setMaxDate) {
                        $("#tagWall").append(' <div class="tag" name="maxDate" style="border:1px solid black; border-radius: 10px; padding: 2px 8px 2px 8px;"><p>Datum do ' + drugi + '  <i class="fa fa-times-circle"  style="float:right;" aria-hidden="true"></i></p></div>');

                    }



                } else if (selected == "3") {
                    setMinPopust = prvi;
                    setMaxPopust = drugi;
                    $('#tagWall').children('.tag').each(function () {
                        //alert($(this).attr("name"));
                        if ($(this).attr("name") == "minPopust" || $(this).attr("name") == "maxPopust") {
                            $(this).remove();

                        }
                    });
                    if (setMinPopust != defMinPopust) {
                        $("#tagWall").append(' <div class="tag" name="minPopust" style="border:1px solid black; border-radius: 10px; padding: 2px 8px 2px 8px;"><p>Popust veći od ' + prvi + '  <i class="fa fa-times-circle"  style="float:right;" aria-hidden="true"></i></p></div>');
                    }
                    if (setMaxPopust != defMaxPopust) {
                        $("#tagWall").append(' <div class="tag" name="maxPopust" style="border:1px solid black; border-radius: 10px; padding: 2px 8px 2px 8px;"><p>Popust manji od ' + drugi + '  <i class="fa fa-times-circle"  style="float:right;" aria-hidden="true"></i></p></div>');
                    }

                } else if (selected == "4") {
                    setMinBrKnjiga = prvi;
                    setMaxBrKnjiga = drugi;
                    $('#tagWall').children('.tag').each(function () {
                        //alert($(this).attr("name"));
                        if ($(this).attr("name") == "minBrKnjiga" || $(this).attr("name") == "maxBrKnjiga") {
                            $(this).remove();

                        }
                    });
                    if (setMinBrKnjiga != defMinBrKnjiga) {
                        $("#tagWall").append(' <div class="tag" name="minBrKnjiga" style="border:1px solid black; border-radius: 10px; padding: 2px 8px 2px 8px;"><p>Broj knjiga veći od ' + prvi + '  <i class="fa fa-times-circle"  style="float:right;" aria-hidden="true"></i></p></div>');
                    }
                    if (setMaxBrKnjiga != defMaxBrKnjiga) {
                        $("#tagWall").append(' <div class="tag" name="maxBrKnjiga" style="border:1px solid black; border-radius: 10px; padding: 2px 8px 2px 8px;"><p>Broj knjiga manji od ' + drugi + '  <i class="fa fa-times-circle"  style="float:right;" aria-hidden="true"></i></p></div>');
                    }

                } else if (selected == "5") {

                    setMinIznos = prvi;
                    setMaxIznos = drugi;
                    $('#tagWall').children('.tag').each(function () {
                        //alert($(this).attr("name"));
                        if ($(this).attr("name") == "minIznos" || $(this).attr("name") == "maxIznos") {
                            $(this).remove();

                        }
                    });
                    if (setMinIznos != defMinIznos) {
                        $("#tagWall").append(' <div class="tag" name="minIznos" style="border:1px solid black; border-radius: 10px; padding: 2px 8px 2px 8px;"><p>Iznos veći od ' + prvi + '  <i class="fa fa-times-circle"  style="float:right;" aria-hidden="true"></i></p></div>');
                    }
                    if (setMaxIznos != defMaxIznos) {
                        $("#tagWall").append(' <div class="tag" name="maxIznos"  style="border:1px solid black; border-radius: 10px; padding: 2px 8px 2px 8px;"><p>Iznos manji od ' + drugi + '  <i class="fa fa-times-circle"  style="float:right;" aria-hidden="true"></i></p></div>');
                    }
                } else if (selected == "7") {
                    if (!knjige.includes(prvi)) {
                        knjige.push(prvi);
                        $("#tagWall").append(' <div class="tag" name="knjige" style="border:1px solid black; border-radius: 10px; padding: 2px 8px 2px 8px;"><p>' + prvi + '  <i class="fa fa-times-circle" style="float:right;" aria-hidden="true"></i></p></div>');
                    }
                }
            }
            $(".tag").click(function () {
                //   var nesto = $("#tagWall").children(".tag").clone();
                //alert($("#tagWall").children(".tag").attr('name'));


                //for (var i = 0; i < nesto.length; i++) {
                // alert(nesto[i].attr("name"));
                //}
                var ime = $(this).attr('name');
                // alert($(this).attr('name'));
                if (ime == "minDate") {
                    //       alert(1);
                    setMinDate = defMinDate;
                    obnoviRacune();
                } else if (ime == "maxDate") {
                    setMaxDate = defMaxDate;
                    obnoviRacune();
                } else if (ime == "minPopust") {
                    setMinPopust = defMinPopust;
                    obnoviRacune();

                } else if (ime == "maxPopust") {
                    setMaxPopust = defMaxPopust;
                    obnoviRacune();
                } else if (ime == "minBrKnjiga") {
                    setMinBrKnjiga = defMinBrKnjiga;
                    obnoviRacune();
                } else if (ime == "maxBrKnjiga") {
                    setMaxBrKnjiga = defMaxBrKnjiga;
                    obnoviRacune();
                } else if (ime == "minIznos") {
                    setMinIznos = defMinIznos;
                    obnoviRacune();
                } else if (ime == "maxIznos") {
                    setMaxIznos = defMaxIznos;
                    obnoviRacune();
                } else if (ime == "kupac") {

                    kupci.splice(kupci.indexOf($(this).find("p").text()), 1);
                    obnoviRacune();
                } else if (ime == "knjige") {

                    knjige.splice(knjige.indexOf($(this).find("p").text()), 1);
                    obnoviRacune();
                }
                $(this).remove();
            });


            obnoviRacune();

        });



        <%

            List<Racun> listaRacuna = ControllerPL.getInstanca().vratiRacune();


        %>



        function onLoad() {


        <%                 Date dateMin = new Date();
            Date dateMax = new Date();
            double popustMin = 100;
            double popustMax = 0;
            double iznosMin = 1000;
            double iznosMax = 0;
            int knjigeMin = 100;
            int knjigeMax = 0;
            boolean setMax = false;

            for (Racun r : listaRacuna) {
                if (r.getVreme().before(dateMin)) {
                    dateMin = r.getVreme();
                }
                if (r.getVreme().after(dateMax) || !setMax) {
                    setMax = true;
                    dateMax = r.getVreme();
                }
                if (r.getPopust() < popustMin) {
                    popustMin = r.getPopust();
                }
                if (r.getPopust() > popustMax) {
                    popustMax = r.getPopust();
                }
                if (r.getIznos() < iznosMin) {
                    iznosMin = r.getIznos();
                }
                if (r.getIznos() > iznosMax) {
                    iznosMax = r.getIznos();
                }
                if (r.getStavkaracunaList().size() > knjigeMax) {
                    knjigeMax = r.getStavkaracunaList().size();
                }
                if (r.getStavkaracunaList().size() < knjigeMin) {
                    knjigeMin = r.getStavkaracunaList().size();
                }
                /* List<Date> namesList = listaRacuna.stream()
                        .map(Racun::getVreme)
                        .collect(Collectors.toList());
                Date minDate = Collection.min(namesList);*/
                SimpleDateFormat sdf = new SimpleDateFormat("dd-MM-yyyy");
                String s = sdf.format(r.getVreme());
                String stavke = "";
                for (Stavkaracuna sr : r.getStavkaracunaList()) {
                    stavke += sr.getStavkaRacunaID() + "-" + sr.getNazivKnjige() + "-" + sr.getCena() + "/";

                }
        %>


            listaRacun.push({
                'id': '<%=r.getRacunID()%>',
                'kupac': '<%=r.getKupacID().getUser().getImeIPrezime()%>',
                'vreme': '<%=s%>',
                'popust': '<%=Math.round(r.getPopust() * 100)%>',
                'brojKnjiga': '<%= r.getStavkaracunaList().size()%>',
                'iznos': '<%=Math.round(r.getIznos())%>',
                'stavke': '<%=stavke%>',
            });
            dodajRacuneUTabelu(listaRacun[listaRacun.length - 1]);
        <%
            }

            SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");

        %>

            defMinDate = setMinDate = "<%=sdf.format(dateMin)%>";
            defMaxDate = setMaxDate = "<%=sdf.format(dateMax)%>";
            defMinPopust = setMinPopust = "<%=popustMin * 100%>";
            defMaxPopust = setMaxPopust = "<%=popustMax * 100%>";
            defMinIznos = setMinIznos = "<%=iznosMin%>";
            defMaxIznos = setMaxIznos = "<%=iznosMax%>";
            defMinBrKnjiga = setMinBrKnjiga = "<%=knjigeMin%>";
            defMaxBrKnjiga = setMaxBrKnjiga = "<%=knjigeMax%>";
             $("#brRezultata").text( "Nađeno je " + listaRacun.length+ " računa");
        }




        var listaRacun = [];

        onLoad();
        var trenutnaLista = listaRacun;
        function dodajRacuneUTabelu(racun) {

            $("#detaljiRacun1").append(' <tr class="racun" name=' + racun.id + '><td>' + racun.kupac + '</td><td>' + racun.vreme + '</td><td>' + racun.popust + '% </td><td>' + racun.brojKnjiga + '</td> <td>' + racun.iznos + '</td> </tr>');
        }



        var idRacunaZaIzmenu;
        var popustStari;
        $(document).on({
            mouseenter: function () {


                if ((this).id != "tableHeader") {
                    $(this).append("<td id='dodatak'><img id='izmeniIkona'  style='width:30px; margin-left:5px;' src='http://localhost:8084/pj1/images/izmeniIcon.png'><img id='deleteIkona' style='width:32px; margin-left:5px;' src='http://localhost:8084/pj1/images/deleteIcon.png'></td>");
                    $(this).find(">:first-child").prepend("<img id='strelica' style='margin-right:10px;' src='http://localhost:8084/pj1/images/strelicaNaDesno.png'>");
                    $(this).find(">:first-child").css("padding", "10px 50px 10px 20px");
                }

                $("#izmeniIkona").click(function () {

                    $("#bgIzmeni").css("display", "block");
                    $("#izmeniRacun").fadeIn("fast");
                    var id = $(this).parent().parent().attr("name");
                    idRacunaZaIzmenu = id;
                    for (var i = 0; i < listaRacun.length; i++) {
                        if (id == listaRacun[i].id) {
                            $("#tabelaStavkaRacuna tr[name=filler]").remove();
                            var datum = listaRacun[i].vreme.split("-");
                            var datum1 = datum[2] + '-' + datum[1] + "-" + datum[0];
                            $("#kupacIme").val(listaRacun[i].kupac);
                            $("#datumRacun").val(datum1);
                            $("#popustIzmena").val(listaRacun[i].popust);
                            $("#iznosIzmena").val(listaRacun[i].iznos);
                            var stavke = listaRacun[i].stavke.split("/");
                            $(".stavkeRacuna").remove();
                            popustStari = listaRacun[i].popust;
                            for (var y = 0; y < stavke.length - 1; y++) {
                                var m = stavke[y].split("-");
                                $("#tabelaStavkaRacuna").append('<tr class="stavkeRacuna" name=' + m[0] + '><td>' + (y + 1) + '</td> <td>' + m[1] + '</td><td>' + m[2] + '</td> </tr>');
                            }
                            var brojStavki = stavke.length - 1;
                            if (brojStavki > 5) {
                                $("#tabelaStavkaRacuna").css("overflow-y", "scroll");
                            }

                            while (brojStavki < 5) {
                                $("#tabelaStavkaRacuna").append('<tr name="filler"><td> </td> <td> </td><td> </td> </tr>');
                                brojStavki++;
                            }

                            break;
                        }
                    }



                });
                $("#deleteIkona").click(function () {
                    $("#racunZaBrisanje").val($(this).parent().parent().attr("name"));
                    $("#formaRacunZaBrisanje").submit();
                });
            }
            , mouseleave: function () {

                $('#dodatak').remove();
                $(this).find(">:first-child").css("padding", "10px 50px 10px 50px");
                $('#strelica').remove();
            }
        }, "#detaljiRacun1 tr");
        function dynamicSort(property) {
            var sortOrder = 1;
            if (property[0] === "-") {
                sortOrder = -1;
                property = property.substr(1);
            }

            return function (a, b) {
                if (sortOrder == -1) {
                    return b[property].localeCompare(a[property]);
                } else {
                    return a[property].localeCompare(b[property]);
                }
            }
        }

        var sortiranje = [false, false, false, false, false];
        $("#tableHeader th").click(function () {

            var akcija = $(this).text();
            //  alert(akcija);
            var lista = trenutnaLista;
            // alert(lista[0]);
            if (akcija == "Kupac") {
                if (!sortiranje[0]) {
                    trenutnaLista.sort(dynamicSort("-kupac"));
                    sortiranje[0] = true;
                } else {
                    trenutnaLista.sort(dynamicSort("kupac"));
                    sortiranje[0] = false;
                }
            } else if (akcija == "Vreme") {
                if (!sortiranje[1]) {
                    sortiranje[1] = true;
                    trenutnaLista.sort(function (a, b) {
                        var datum = a.vreme.split("-");
                        //   var datum1 = datum[2] + '-' + datum[1] + "-" + datum[0];
                        var datum2 = b.vreme.split("-");
                        //  var datum3 = datum2[2] + '-' + datum2[1] + "-" + datum2[0];


                        var dateA = new Date(datum[2], datum[1], datum[0]), dateB = new Date(datum2[2], datum2[1], datum2[0]);
                        return dateA - dateB;
                    });
                    // listaRacun.sort(dynamicSort("-vreme"));
                } else {
                    sortiranje[1] = false;
                    trenutnaLista.sort(function (b, a) {
                        var datum = a.vreme.split("-");
                        //   var datum1 = datum[2] + '-' + datum[1] + "-" + datum[0];
                        var datum2 = b.vreme.split("-");
                        //  var datum3 = datum2[2] + '-' + datum2[1] + "-" + datum2[0];


                        var dateA = new Date(datum[2], datum[1], datum[0]), dateB = new Date(datum2[2], datum2[1], datum2[0]);
                        return dateA - dateB;
                    });
                }


            } else if (akcija == "Popust") {
                if (!sortiranje[2]) {
                    sortiranje[2] = true;
                    trenutnaLista.sort(function (a, b) {
                        return a.popust - b.popust;
                    });
                } else {
                    sortiranje[2] = false;
                    trenutnaLista.sort(function (b, a) {
                        return a.popust - b.popust;
                    });
                }
            } else if (akcija == "Broj knjiga") {
                if (!sortiranje[3]) {
                    sortiranje[3] = true;
                    trenutnaLista.sort(dynamicSort("-brojKnjiga"));
                } else {
                    sortiranje[3] = false;
                    trenutnaLista.sort(dynamicSort("brojKnjiga"));
                }
            } else if (akcija == "Iznos") {

                if (!sortiranje[4]) {
                    sortiranje[4] = true;
                    trenutnaLista.sort(dynamicSort("-iznos"));
                } else {
                    sortiranje[4] = false;
                    trenutnaLista.sort(dynamicSort("iznos"));
                }

            }


            $(".racun").remove();
            for (var i = 0; i < trenutnaLista.length; i++) {
                dodajRacuneUTabelu(trenutnaLista[i]);
            }





        });
        $("#izmeniRacunBtn").click(function () {
            var datum = document.getElementById("datumRacun").value;
            var popust = document.getElementById("popustIzmena").value;
            var iznos = document.getElementById("iznosIzmena").value / (1 - (popustStari / 100));
            iznos = iznos * (1 - (popust / 100));
            document.getElementById("iznosIzmena").value = iznos;
            document.getElementById("racunID").value = idRacunaZaIzmenu;
            alert(idRacunaZaIzmenu);
            $("#formaIzmeniRacun").submit();
        });
        $(document).on({
            mouseenter: function () {

                $(this).css("transition", "background-color 0.5s ease");
                $(this).css("background", "#e8eeef");
            },
            mouseleave: function () {
                $(this).css("background", "none");
            }
        }, ".stavkeRacuna");
        $("#nazadBtn").click(function () {
            $("#bgIzmeni").fadeOut("fast");
            $("#izmeniRacun").fadeOut("fast");
        });
        var trigger = false;
        $("#detaljiRacun1 tr td").click(function () {
            if ((this).id != "tableHeader") {
                //  $("#strelica").toggleClass("down");

                // $(this).parent().append('<tr><th>Knjiga</th><th>Cena</th></tr>');

            }
        });




    </script>

</html>
