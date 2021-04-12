/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package action.dao;

import domen.Zanr;
import java.util.List;
import javax.persistence.EntityManager;
import javax.persistence.EntityManagerFactory;
import javax.persistence.Persistence;

/**
 *
 * @author Pumpkin
 */
public class ZanrDao implements Dao<Zanr> {

    EntityManagerFactory emf = Persistence.createEntityManagerFactory("pj1PU");

  

    @Override
    public Zanr get(Object... args) {
        throw new UnsupportedOperationException("Not supported yet."); //To change body of generated methods, choose Tools | Templates.
    }

    @Override
    public List<Zanr> getAll() {
        EntityManager em = emf.createEntityManager();
        em.getTransaction().begin();

        List<Zanr> listaZanrova = em.createQuery("SELECT z FROM Zanr z").getResultList();
        return listaZanrova;
    }

    @Override
    public void save(Zanr t) {
        throw new UnsupportedOperationException("Not supported yet."); //To change body of generated methods, choose Tools | Templates.
    }

    @Override
    public void update(Zanr t) {
        throw new UnsupportedOperationException("Not supported yet."); //To change body of generated methods, choose Tools | Templates.
    }

    @Override
    public void delete(Zanr t) {
        throw new UnsupportedOperationException("Not supported yet."); //To change body of generated methods, choose Tools | Templates.
    }

}
