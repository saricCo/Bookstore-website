<%-- 
    Document   : footer
    Created on : 17-Jan-2020, 00:31:36
    Author     : Pumkin-duke
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>

<div class="footer1"> 

</div>





</body>
<script src="jquery-3.1.1.js"></script>
<script src="js/jquery-1.12.3.min.js"></script>
<script src="js/ion.rangeSlider.js"></script>
<jsp:include page="js/javascript.jsp" />


<script>


    <%
        HttpSession sessionsa = request.getSession(false);

        String poruka = (String) sessionsa.getAttribute("poruka");
        String subPoruka = (String) sessionsa.getAttribute("sub-poruka");

        if (poruka == "Greška prilikom logovanja!") {
    %>

    $("#reglogGlavna").show();

    <%
        }
        if (poruka != null) {
    %>
    var poruka = "<%=poruka%>";
    var subPoruka = '<%=subPoruka%>';
    $("#poruka").text(poruka);
    $("#sub-poruka").text(subPoruka);

    //$(".overlay").show();
    $(".overlay").css("visibility", "visible");
    $(".close").click(function () {
        $(".overlay").css("visibility", "hidden");
    });


    <%
            sessionsa.setAttribute("poruka", null);
        }
    %>


</script>
</html>
