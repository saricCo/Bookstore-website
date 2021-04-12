/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package action.dao;

import controller.pl.ControllerPL;
import domen.Iznajmica;
import domen.Knjiga;
import domen.Korisnik;
import java.util.AbstractList;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;
import java.util.Objects;
import javax.persistence.EntityManager;
import javax.persistence.EntityManagerFactory;
import javax.persistence.Persistence;

/**
 *
 * @author Pumkin-duke
 */
public class IznajmicaDao implements Dao<Iznajmica> {

    EntityManagerFactory emf = Persistence.createEntityManagerFactory("pj1PU");

    @Override
    public Iznajmica get(Object... args) {
        throw new UnsupportedOperationException("Not supported yet."); //To change body of generated methods, choose Tools | Templates.
    }

    @Override
    public List<Iznajmica> getAll() {
        EntityManager em = emf.createEntityManager();
        em.getTransaction().begin();

        List<Iznajmica> lista = em.createQuery("SELECT i FROM Iznajmica i").getResultList();

        return lista;
    }

    @Override
    public void save(Iznajmica t) {
        throw new UnsupportedOperationException("Not supported yet."); //To change body of generated methods, choose Tools | Templates.
    }

    @Override
    public void update(Iznajmica t) {
        throw new UnsupportedOperationException("Not supported yet."); //To change body of generated methods, choose Tools | Templates.
    }

    @Override
    public void delete(Iznajmica t) {

        EntityManager em = emf.createEntityManager();
        em.getTransaction().begin();
        Iznajmica i = em.find(Iznajmica.class, t.getIznajmicaID());
        em.remove(i);
        em.getTransaction().commit();
    }

    public int getCount(int id) {
        EntityManager em = emf.createEntityManager();
        em.getTransaction().begin();
        List<Iznajmica> lista = em.createQuery("SELECT i FROM Iznajmica i WHERE i.korisnikID.korisnikID=" + id).getResultList();

        return lista.size();

    }

    public List<Iznajmica> getForUser(Korisnik k) {
        List<Iznajmica> listaKon = new ArrayList<>();
        List<Iznajmica> lista = getAll();

        for (Iznajmica i : lista) {
            //   System.out.println(i.getKorisnikID().getKorisnikID()+" --  "+k.getKorisnikID());
            if (Objects.equals(i.getKorisnikID(), k)) {

                listaKon.add(i);
            }
        }
        System.out.println(listaKon.size());
        return listaKon;
    }

    public void izbrisiVraceneKnjige() {
        List<Iznajmica> lista = getAll();
        for (Iznajmica i : lista) {

            if (i.getDatumPovracaja().before(new Date())) {

                Knjiga k = i.getKnjigaID();
                k.setStanjeNaLageru(k.getStanjeNaLageru() + 1);
                ControllerPL.getInstanca().izmeniKnjigu(k);
                delete(i);

            }

        }
    }

}
