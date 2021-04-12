<%-- 
    Document   : dodaj_knjigu
    Created on : Jan 30, 2019, 2:40:33 PM
    Author     : Pumpkin
--%>

<%@page import="java.awt.Image"%>
<%@page import="java.io.IOException"%>
<%@page import="java.awt.image.BufferedImage"%>
<%@page import="javax.imageio.ImageIO"%>
<%@page import="java.io.File"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>

    <jsp:include page="../../header.jsp" />





    <div class="contentForma" >
        <input type="hidden" name="action" value="dodaj_knjigu"/>
        <%

        %>

        <strong style="float:left; margin:15px 0px 0px 225px; font-size:25px; "> Preview</strong>
        <div style="clear: left; float:left; min-width:34.74%;  " class="knjiga">
            <img  style="width: 293px; height:450px; margin-right: 7px; float:left;" id="blah"  src="http://localhost:8084/pj1/images/noImage.jpg" onerror="this.src='http://localhost:8084/pj1/images/noImage.jpg'">

            <div style="height:100%" class="sadrzajKnjige"> 

                <div class="sadrzajOpis"> 

                    <p id="opisPreview"></p>
                </div>
                <div style="height:40%">    
                    <br>
                    <strong id="autorPreview">Pisac:  
                        <br>
                    </strong>
                    <br>
                    <br>
                    <strong> Zanr: </strong>
                    <br>
                    <br>
                    <br>
                    <strong id="cenaPreview"> Cena: </strong>
                    <br>

                </div>
            </div>


        </div>
        <div id="forma"  class="form-style-5">
            <form   action="FrontController" enctype="multipart/form-data" method="post" >
                <input type="hidden" name="action" value="unesi_knjigu" autocomplete="off" />
                <input id="korisnikKupac" type="hidden" name="korisnik" value=""/>
                <table id="tableForma">

                    <div class="field">
                        <input type="text" name="nazivKnjige" size="80" placeholder="Unesi naziv knjige" autocomplete="off"/>
                    </div>

                    <div class="field">
                        <input id="autor" type="text" name="nazivPisca" size="80" placeholder="Unesi ime i prezime pisca" autocomplete="off"/>
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
                        <textarea id="opis" style=" height:100%" name="opis" placeholder="Unesi opis za knjigu" ></textarea>
                    </div> 
                    <div class="field">
                        <input id="izdavac" type="text" name="nazivIzdavaca" size="80" placeholder="Unesi izdavača" autocomplete="off"/>
                    </div>
                    <div class="field">
                        <input type="text" name="godinaIzdanja" size="80" placeholder="Unesi godinu štampanja" autocomplete="off"/>
                    </div>
                    <div class="field">
                        <input type="text" name="brojZaUnos" size="80" placeholder="Unesi broj kopija" autocomplete="off"/>
                    </div>

                    <div class="field">
                        <input type="text" name="zanr" size="80" placeholder="Zanr" autocomplete="off"/>
                    </div>

                       <input id="namena1" type="hidden"  name="namena1" value="ZA_IZNAJMLJIVANJE" />
                    <div class="field" style="width: 100%; margin-left: 7%;float: left;">
                        <input id="namenaKnjige" style=" cursor: pointer; display:inline-block; float:left; margin:4px 15px 0 0;" type="checkbox" name="namena" value="ZA_IZNAJMLJIVANJE" />
                        <p style="float:left;font-family: Georgia, 'Times New Roman', Times, serif; cursor:default; ">Za prodaju</p>
                    </div>


                    <div class="field">
                      
                        <input id="saveKnjiga" type="submit" value="Save"/>  
                       
                    </div>

                </table>
            </form> 
        </div>
    </div>
  
        
<jsp:include page="../../footer.jsp" />

<script>






    $("#namenaKnjige").click(function () {
        if ($(this).prop("checked")) {
            $(this).val("ZA_PRODAJU");
             $("#namena1").val("ZA_PRODAJU");
        }
        else {
             $(this).val("ZA_IZNAJMLJIVANJE");
             $("#namena1").val("ZA_IZNAJMLJIVANJE");
        }
    });

    $("#saveKnjiga").click(function () {


        document.getElementById("korisnikKupac").value = idKorisnika;
        var opis = document.getElementById("opis").value;

        document.getElementById("opis").value = vratiKodovanaSlova(opis);
        var imeIPrezime = document.getElementById("autor").value;
        document.getElementById("autor").value = vratiKodovanaSlova(imeIPrezime);
        var izdavac = document.getElementById("izdavac").value;
        document.getElementById("izdavac").value = vratiKodovanaSlova(izdavac);


        $('#forma').submit();

    });

    function readURL(input) {

        if (input.files && input.files[0]) {
            var reader = new FileReader();
            reader.onload = function (e) {
                $('#blah').attr('src', e.target.result);
            }

            reader.readAsDataURL(input.files[0]);
        }
    }

    $("#chooseFile").change(function () {
        var filename = $("#chooseFile").val();
        if (/^\s*$/.test(filename)) {
            $(".file-upload").removeClass('active');
            $("#noFile").text("No file chosen...");
        }
        else {
            $(".file-upload").addClass('active');
            $("#noFile").text(filename.replace("C:\\fakepath\\", ""));
        }

        readURL(this);
    });
    $("#opis").change(function () {
        $("#opisPreview").html(document.getElementById("opis").value);
    });
    $("#autor").change(function () {
        $("#autorPreview").html("Pisac: <br>" + document.getElementById("autor").value);
    });
    $("#cena").change(function () {
        $("#cenaPreview").html("Cena:  " + document.getElementById("cena").value);

    });








</script>
</html>
