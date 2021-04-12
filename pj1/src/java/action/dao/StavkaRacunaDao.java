/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package action.dao;

import domen.Racun;
import domen.Stavkaracuna;
import java.util.List;
import javax.persistence.EntityManager;
import javax.persistence.EntityManagerFactory;
import javax.persistence.Persistence;

/**
 *
 * @author Pumpkin
 */
public class StavkaRacunaDao implements Dao<Stavkaracuna> {

    EntityManagerFactory emf = Persistence.createEntityManagerFactory("pj1PU");

    @Override
    public Stavkaracuna get(Object... args) {
        throw new UnsupportedOperationException("Not supported yet."); //To change body of generated methods, choose Tools | Templates.
    }

    @Override
    public List<Stavkaracuna> getAll() {
        throw new UnsupportedOperationException("Not supported yet."); //To change body of generated methods, choose Tools | Templates.
    }

    @Override
    public void save(Stavkaracuna t) {
        throw new UnsupportedOperationException("Not supported yet."); //To change body of generated methods, choose Tools | Templates.
    }

    @Override
    public void update(Stavkaracuna t) {
        throw new UnsupportedOperationException("Not supported yet."); //To change body of generated methods, choose Tools | Templates.
    }

    @Override
    public void delete(Stavkaracuna sr) {
         throw new UnsupportedOperationException("Not supported yet."); //To change body of generated methods, choose Tools | Templates.
  
    
    }
    public void deleteAll(Racun r2){
        
        EntityManager em = emf.createEntityManager();
        em.getTransaction().begin();
        List<Racun> lista = new RacunDao().getAll();
        Racun r1 = new Racun();
        for (Racun r : lista) {
            if (r.getRacunID() == r2.getRacunID()) {
                r1 = r;
                break;
            }
        }

        for (Stavkaracuna sr : r1.getStavkaracunaList()) {
            Stavkaracuna sr1 = em.find(Stavkaracuna.class, sr.getStavkaRacunaID());
            em.remove(sr1);

        }
        em.getTransaction().commit();
    
        
    }
    
    

    public int vratiMaxID() {

        EntityManager em = emf.createEntityManager();
        em.getTransaction().begin();
        int broj = 0;
        try {
            broj = (int) em.createQuery("SELECT max(sr.stavkaRacunaID) FROM Stavkaracuna sr").getSingleResult();
        } catch (Exception ex) {
            return 1;
        }
        return broj + 1;
    }

}
