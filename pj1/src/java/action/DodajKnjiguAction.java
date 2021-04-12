/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package action;

import controller.pl.ControllerPL;
import domen.Knjiga;
import domen.Zanr;
import java.awt.AlphaComposite;
import java.awt.Graphics2D;
import java.awt.Image;
import java.awt.image.BufferedImage;
import java.io.File;
import java.io.IOException;
import java.io.InputStream;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.List;
import java.util.logging.Level;
import java.util.logging.Logger;
import javax.imageio.ImageIO;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;
import javax.servlet.http.Part;

/**
 *
 * @author Pumpkin
 */
public class DodajKnjiguAction extends AbstractAction {

    @Override
    public String izvrsi(HttpServletRequest request) {

        try {
            String nazivKnjige = request.getParameter("nazivKnjige");
            Part filePart = request.getPart("photo");
            InputStream is = null;
            String fileContent = filePart.getContentType();
            if (filePart != null) {
                is = filePart.getInputStream();
            }
            Image image = ImageIO.read(is);

            BufferedImage bi = this.createResizedCopy(image, 292, 450, true);

            ImageIO.write(bi, "jpg", new File("C:\\Banzai\\Documents\\NetBeansProjects\\img\\" + nazivKnjige.replace(" ", "_").toLowerCase() + ".jpg"));

            Knjiga k = new Knjiga();

            k.setNaziv(request.getParameter("nazivKnjige"));

            k.setPisac(ControllerPL.getInstanca().dekodujSlova(request.getParameter("nazivPisca")));
            k.setIzdavac(ControllerPL.getInstanca().dekodujSlova(request.getParameter("nazivIzdavaca")));
            k.setCena(Double.parseDouble(request.getParameter("cena")));
            k.setOpis(ControllerPL.getInstanca().dekodujSlova(request.getParameter("opis")));
            k.setGodinaIzdavanja(Integer.parseInt(request.getParameter("godinaIzdanja")));
            k.setStanjeNaLageru(Integer.parseInt(request.getParameter("brojZaUnos")));
            String zanroviString = request.getParameter("zanr");
            String[] zanrovi = zanroviString.split(", ");
            List<Zanr> lista = ControllerPL.getInstanca().vratiZanr();
            List<Zanr> listaZanrova = new ArrayList<>();
            for (String s : zanrovi) {
                for (Zanr z : lista) {

                    if (z.getNaziv().equals(s)) {
                        Zanr z1 = new Zanr(z.getZanrID(), s);
                        listaZanrova.add(z1);
                        break;
                    }
                }

            }

            k.setZanrList(listaZanrova);

            k.setStatus(request.getParameter("namena1"));
            k.setKnjigaID(7);

            ControllerPL.getInstanca().sacuvajKnjigu(k);

            HttpSession sesija = request.getSession(true);
            sesija.setAttribute("poruka", "Sistem je zapamtio knjigu!");
            sesija.setAttribute("sub-poruka", "Dodata je knjiga sa nazivom \""+k.getNaziv()+"\"");
            return "index";
        } catch (IOException ex) {
            Logger.getLogger(DodajKnjiguAction.class.getName()).log(Level.SEVERE, null, ex);
        } catch (ServletException ex) {
            Logger.getLogger(DodajKnjiguAction.class.getName()).log(Level.SEVERE, null, ex);
        }

        HttpSession sesija = request.getSession(true);
        sesija.setAttribute("poruka", "Nesto");
        return "index";
    }

    BufferedImage createResizedCopy(Image originalImage, int scaledWidth, int scaledHeight, boolean preserveAlpha) {
        int imageType = preserveAlpha ? BufferedImage.TYPE_INT_RGB : BufferedImage.TYPE_INT_ARGB;
        BufferedImage scaledBI = new BufferedImage(scaledWidth, scaledHeight, imageType);
        Graphics2D g = scaledBI.createGraphics();
        if (preserveAlpha) {
            g.setComposite(AlphaComposite.Src);
        }
        g.drawImage(originalImage, 0, 0, scaledWidth, scaledHeight, null);
        g.dispose();
        return scaledBI;
    }

}
