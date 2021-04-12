<%-- 
    Document   : javascript
    Created on : Feb 7, 2019, 10:00:41 PM
    Author     : Pumpkin
--%>

<%@page import="domen.Admin"%>
<%@page import="java.util.List"%>
<%@page import="controller.pl.ControllerPL"%>
<%@page import="domen.Knjiga"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>




    <script>







        var status = "ZA_PRODAJU";




        $("#submitRegistracija").click(
                function () {

                    var pass1 = $("#pass1").val();
                    var pass2 = $("#pass2").val();
                    if (pass1 == pass2) {
                        $('#formaRegistracija').submit();
                    } else {
                        $("#pass2")[0].setCustomValidity('Greska, polja za password nisu ista');
                        $("#pass2")[0].checkValidity();
                    }
                });


        $("#login").click(
                function () {
                    $("#login").css("background-color", "#3b4745");
                    $("#register").css("background-color", "#18b495");
                    $("#formaRegistracija").css("display", "none");
                    $("#formaLogin").css("display", "block");
                });
        $("#register").click(
                function () {

                    $("#login").css("background-color", "#18b495");
                    $("#register").css("background-color", "#3b4745");
                    $("#formaLogin").css("display", "none");
                    $("#formaRegistracija").css("display", "block");
                });
        $(".nazad").click(
                function () {
                    $("#reglogGlavna").css("display", "none");
                    $(".knjiga").css("z-index", "0");
                });
        $("#registerLogin").click(
                function () {
                    $(".knjiga").css("z-index", "-5");
                    $("#reglogGlavna").fadeIn("fast");

                });




        $("#kupovina").click(
                function () {
                    status = "ZA_PRODAJU";
                    $(this).css("background-color", "#3C948B");
                    $(this).css("box-shadow", "3px 0px 1px #585858");

                    $("#iznajmljivanje").css("background-color", "#e1e3e4");
                    $("#iznajmljivanje").css("box-shadow", "none");
                    $("#prvi").css("border", "none");
                });
        $("#iznajmljivanje").click(
                function () {
                    status = "ZA_IZNAJMLJIVANJE";
                    $("#kupovina").css("background-color", "#e1e3e4");
                    $("#kupovina").css("box-shadow", "none");

                    $(this).css("box-shadow", "-2px 0px 1px #585858");
                    $(this).css("background-color", "#3C948B");

                    $("#prvi").css("border", "none");

                });

        <%
            HttpSession sesija = request.getSession(false);
            if (sesija != null) {
                String registracija = (String) sesija.getAttribute("greskaRegistracija");
                session.removeAttribute("greskaRegistracija");

                if (registracija != null) {
        %>

        $(".knjiga").css("z-index", "-5");
        $("#reglogGlavna").css("display", "block");
        $("#login").css("background-color", "#18b495");
        $("#register").css("background-color", "#3b4745");
        $("#formaLogin").css("display", "none");
        $("#formaRegistracija").css("display", "block");

        $("#greskaRegistracija").text("<%=registracija%>");
        <%
        } else {

            registracija = (String) sesija.getAttribute("uspesnaRegistracija");
            session.removeAttribute("uspesnaRegistracija");
            if (registracija != null) {
        %>
        $(".knjiga").css("z-index", "-5");
        $("#reglogGlavna").css("display", "block");
        $("#login").css("background-color", "#3b4745");
        $("#register").css("background-color", "#18b495");
        $("#formaRegistracija").css("display", "none");
        $("#formaLogin").css("display", "block");
        $("#uspesnaRegistracija").text("<%=registracija%>");


        <%
                    }

                }

            }


        %>



        //dropdown pretraga
        $("#dropdown0").click(
                function () {
                    $(this).siblings().removeClass('boja');
                    $(this).siblings().removeClass('open');



                    $("#dropdownMenu1").hide();
                    $("#dropdownMenu2").hide();
                    $("#dropdownMenu3").hide();


                });
        $("#dropdown1").click(
                function () {
                    $(this).toggleClass('boja').siblings().removeClass('boja');
                    $(this).toggleClass('open').siblings().removeClass('open');
                    if ($("#dropdownMenu1").is(":visible"))
                        $("#dropdownMenu1").hide();
                    else {
                        $("#dropdownMenu0").hide();
                        $("#dropdownMenu1").show();
                        $("#dropdownMenu2").hide();
                        $("#dropdownMenu3").hide();
                        // alert(document.getElementsByClassName("irs-from")[0].innerHTML);
                    }
                });
        $("#dropdown2").click(
                function () {
                    $(this).toggleClass('boja').siblings().removeClass('boja');
                    $(this).toggleClass('open').siblings().removeClass('open');
                    if ($("#dropdownMenu2").is(":visible"))
                        $("#dropdownMenu2").hide();
                    else {
                        $("#dropdownMenu0").hide();
                        $("#dropdownMenu1").hide();
                        $("#dropdownMenu2").show();
                        $("#dropdownMenu3").hide();
                    }
                });
        $("#dropdown3").click(
                function () {
                    $(this).toggleClass('boja').siblings().removeClass('boja');
                    $(this).toggleClass('open').siblings().removeClass('open');
                    if ($("#dropdownMenu3").is(":visible"))
                        $("#dropdownMenu3").hide();
                    else {
                        $("#dropdownMenu0").hide();
                        $("#dropdownMenu1").hide();
                        $("#dropdownMenu2").hide();
                        $("#dropdownMenu3").show();
                        // alert(document.getElementsByClassName("irs-from")[0].innerHTML);
                    }
                });
        $(".dropdownMenu strong").click(
                function () {
                    if ($(this).css("color") != "rgb(60, 148, 139)") {
                        $(this).parent().find("p").css("min-width", "86px");
                        $(this).fadeTo("fast", 0.07);
                        $(this).css("color", "#3C948B");
                        $(this).fadeTo("fast", 3, function () {
                            $(this).fadeTo("fast", 1);
                        });
                        $(this).parent().find("p").show();
                    } else {
                        $(this).fadeTo("fast", 0.07, function () {
                            $(this).css("color", "#717671");
                        });
                        $(this).fadeTo("fast", 3, function () {

                            $(this).fadeTo("fast", 1);
                        });
                    }
                });


        $("#iznajmi01").hover(function () {
            
            $("#iznajmi").css('background', '#f4f4f4');
        },
        function(){
               $("#iznajmi").css('background', '#e1e3e4');
        });


        $("#korpaLi").hover(function () {

            $("#dodajKnjigu").css('background', '#f4f4f4');

        }
        ,
                function () {
                    $("#dodajKnjigu").css('background', '#e1e3e4');
                });
        var a = 60;
        var b = 148;
        var c = 139;
        var d = 0.1;
        $("#pretraga3").click(function ponovi() {


            if (c > 52 || b > 52 || a > 52) {

                if (c - Math.floor(c * d) < 52)
                    c = 52;
                else
                    c -= Math.floor(c * d);
                if (b - Math.floor(b * d) < 52)
                    b = 52;
                else
                    b -= Math.floor(b * d);
                if (a - Math.floor(a * d) < 52)
                    a = 52;
                else
                    a -= Math.floor(a * d);
                setTimeout(function () {
                    $(".text").css('background', 'rgb(' + a + ',' + b + ',' + c + ')');
                    ponovi();
                }, 50);
            }

            $(".bt-search").css('border-left', '1px solid #f4f4f4');
        });
        /*pretraga*/
        var boja = false;
        $("#pretraga3").keyup(function (event) {
            if (event.keyCode === 13) {
                $("#bt-search").click();
                $("#sugestije").hide();
            } else {
                $(".sugestija").remove();
                var ima = 0;
                var unos = $("#pretraga3").val().toLowerCase();
                if (unos.length > 0) {
                    for (var i = 0; i < lista.length; i++)
                    {
                        if ((lista[i].pisac.toLowerCase()).includes(unos) || (lista[i].naziv.toLowerCase()).includes(unos) || (lista[i].izdavac.toLowerCase()).includes(unos) || (lista[i].zanr.toLowerCase()).includes(unos)) {
                            $("#sugestije").slideDown();
                            $("#sugestije").append("<div class='sugestija'> <img style='width: 100px; margin-left:15px;' src=" + lista[i].putanja + " ><div style='width:220px;  float:left;' > <p style='text-align: center;width: 70%;'>" + lista[i].naziv + "</p></div></div>");
                            ima++;
                        }
                    }
                } else
                    $("#sugestije").hide();
                if (ima == 0)
                    $("#sugestije").hide();
            }


        });
        /*prilikom klika van menija, sakriti ih*/
        $(document).click(function (event) {
            if (!$(event.target).closest('#pretraga2').length) {
                if ($('#sugestije').is(":visible")) {
                    $('#sugestije').fadeOut("slow");
                }
            }

            if ($(event.target).closest('.dropdownMenu').length == 0 && $(event.target).closest('.dropdown').length == 0) {
                if ($('.dropdownMenu').is(":visible")) {
                    $('.dropdownMenu').fadeOut("slow");
                    $("#dropdown0").removeClass('boja');
                    $("#dropdown1").removeClass('boja');
                    $("#dropdown2").removeClass('boja');
                    $("#dropdown3").removeClass('boja');
                    $("#dropdown0").removeClass('open');
                    $("#dropdown1").removeClass('open');
                    $("#dropdown2").removeClass('open');
                    $("#dropdown3").removeClass('open');
                }

            }
        });
        /*deo gde nestaju divovi priikom skrolovanja*/
        var skrol = 0;
        $(window).scroll(function () {

            if ($('#sugestije:hover').length == 0) {
                skrol++;
                if (skrol > 2) {
                    $('#sugestije').fadeOut("slow");
                    if ($('.dropdownMenu:hover').length == 0) {
                        $('.dropdownMenu').fadeOut("slow");
                        $("#dropdown0").removeClass('boja');
                        $("#dropdown1").removeClass('boja');
                        $("#dropdown2").removeClass('boja');
                        $("#dropdown3").removeClass('boja');
                        $("#dropdown0").removeClass('open');
                        $("#dropdown1").removeClass('open');
                        $("#dropdown2").removeClass('open');
                        $("#dropdown3").removeClass('open');
                    }
                    skrol = 0;
                }
            }
        });
        /*deo za komentare*/
        //????
        $("#posalji").click(function () {
            if (!$("#komentar").val()) {
                window.alert("Nije moguće poslati prazan komentar");
            } else if (!$("#potpis").val())
            {
                window.alert("Morate uneti potpis ili se prijaviti putem Google account-a ili Facebook-a");
            } else
            {
                var tekst = $("#komentar").val();
                var potpis = $("#potpis").val();
                var dt = new Date();
                var time = dt.getDate() + "." + (dt.getMonth() + 1) + "." + dt.getFullYear() + ".  " + dt.getHours() + ":" + dt.getMinutes();
                $("#komentariPrikaz").append(" <div class='komentar'> <p class='ime'>" + potpis + "</p>  <img class='srce' src='srce2.png'><p class='komentarCSS'> " + tekst + "</p><br><time>" + time + "</time></div> ");
            }

        });
        //????
        $(".srce").click(function () {
            if ($(this).attr("src") == "srce2.png")
                $(this).attr("src", "srce1.png");
            else
                $(this).attr("src", "srce2.png");
        });
        $("#range1").ionRangeSlider({
            hide_min_max: true,
            keyboard: true,
            min: 450,
            max: 2500,
            from: 450,
            to: 2500,
            type: 'double',
            step: 1,
            prefix: "  din ",
            grid: true,
            onFinish: function (data) {


                vratiKnjigePoKriterijumu("cena");
            }
        });
        var kriterijumi = "";
        var slider = $("#range2").data("ionRangeSlider");
        var sliderFromStari = 0;
        $("#range2").ionRangeSlider({
            hide_min_max: true,
            keyboard: true,
            min: 1992,
            max: 2019,
            from: 2000,
            to: 2019,
            type: 'double',
            step: 1,
            prefix: " godina ",
            grid: true,
            onFinish: function (data) {

                vratiKnjigePoKriterijumu("godinaIzdavanja");
                if (sliderFromStari < slider.result.from) {
                    sliderFromStari = slider.result.from;
                    slider.update({
                        min: Math.round(slider.result.from - ((slider.result.to - slider.result.from) / 3))

                                // etc.
                    });
                } else {
                    sliderFromStari = slider.result.from;
                    slider.update({
                        min: Math.round(slider.result.from - ((slider.result.to - slider.result.from)))

                                // etc.
                    });
                }

            }
        });
        var slider = $("#range2").data("ionRangeSlider");
        /*$(".dropdownMenu div div a").hover(
         
         function myLoop() {
         $(this).attr('id', 'linija1');
         },
         function myLoop1() {
         $(this).attr('id', '');
         
         }
         );
         */




        /*za menjanje slika*/
        $("#slika1").click(function () {
            $(this).parent().addClass('currentImg').siblings().removeClass('currentImg');
            $("#preview").fadeOut(300, function () {
                $(this).attr('src', 'Samsung_Galaxy_S7_Edge_1_363x363px.jpg').bind('onreadystatechange load', function () {
                    if (this.complete)
                        $(this).fadeIn(300);
                });
            });
        });
        $("#slika2").click(function () {
            $(this).parent().addClass('currentImg').siblings().removeClass('currentImg');
            $("#preview").fadeOut(300, function () {
                $(this).attr('src', 'Samsung_Galaxy_S7_Edge_2_363x363px.jpg').bind('onreadystatechange load', function () {
                    if (this.complete)
                        $(this).fadeIn(300);
                });
            });
        });
        $("#slika3").click(function () {
            $(this).parent().addClass('currentImg').siblings().removeClass('currentImg');
            $("#preview").fadeOut(300, function () {
                $(this).attr('src', 'Samsung_Galaxy_S7_Edge_3_363x363px.jpg').bind('onreadystatechange load', function () {
                    if (this.complete)
                        $(this).fadeIn(300);
                });
            });
        });
        $("#slika4").click(function () {
            $(this).parent().addClass('currentImg').siblings().removeClass('currentImg');
            $("#preview").fadeOut(300, function () {
                $(this).attr('src', 'Samsung_Galaxy_S7_Edge_4_363x363px.jpg').bind('onreadystatechange load', function () {
                    if (this.complete)
                        $(this).fadeIn(300);
                });
            });
        });
        /*
         function b(){
         a(d).remove(),a(e).each(function(b){
         var d=c(a(this));
         d.hasClass("open")&&(d.trigger(b=a.Event("hide.bs.dropdown")),b.isDefaultPrevented()||d.removeClass("open").trigger("hidden.bs.dropdown"))})}function c(b){var c=b.attr("data-target");c||(c=b.attr("href"),c=c&&/#/.test(c)&&c.replace(/.*(?=#[^\s]*$)/,""));var d=c&&a(c);return d&&d.length?d:b.parent()}var d=".dropdown-backdrop",e="[data-toggle=dropdown]",f=function(b){a(b).on("click.bs.dropdown",this.toggle)};
         
         */
        /* resenje je da se koristi  niz od fazon 700 brojeva i da oni budu rasporedjeni na skali, kad prevlacis samo menjas velicinu niza..*/





        function vratiKodovanaSlova(s) {

            var finalni = " ";
            var m = s.toString();
            // č, ć, dž, đ, lj, nj, š and ž

            for (index = 0; index < s.length; index++) {
                var c = m.charAt(index);
                if (c == 'č')
                {
                    finalni += "^c";
                } else if (c == 'ć') {
                    finalni += "^^c";
                } else if (c == 'đ') {
                    finalni += "^d";
                } else if (c == 'š') {
                    finalni += "^s";
                } else if (c == 'ž') {
                    finalni += "^z";
                } else if (c == 'Č')
                {
                    finalni += "^-c";
                } else if (c == 'Ć') {
                    finalni += "^^-c";
                } else if (c == 'Đ') {
                    finalni += "^-d";
                } else if (c == 'Š') {
                    finalni += "^-s";
                } else if (c == 'Ž') {
                    finalni += "^-z";
                } else
                    finalni += c;
            }


            return finalni;
        }







    </script>
</html>
