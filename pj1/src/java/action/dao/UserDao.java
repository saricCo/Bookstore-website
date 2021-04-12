/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package action.dao;

import domen.User;
import java.util.List;
import javax.persistence.EntityManager;
import javax.persistence.EntityManagerFactory;
import javax.persistence.Persistence;

/**
 *
 * @author Pumpkin
 */
public class UserDao implements Dao<User> {

    EntityManagerFactory emf = Persistence.createEntityManagerFactory("pj1PU");

    @Override
    public User get(Object... args) {
        String username = (String) args[0];
        List<User> useri = getAll();
        for (User u : useri) {
            if (u.getUsername().equals(username)) {

                return u;
            }
        }
        return null;
    }

    @Override
    public List<User> getAll() {
        EntityManager em = emf.createEntityManager();
        em.getTransaction().begin();

        List<User> lista = em.createQuery("SELECT u FROM User u").getResultList();

        return lista;

    }

    @Override
    public void save(User u) {
        EntityManager em = emf.createEntityManager();
        em.getTransaction().begin();
        try {
            em.persist(u);
            em.getTransaction().commit();
            em.close();

        } catch (Exception ex) {
            System.out.println("Greska: " + ex);
        }

    }

    @Override
    public void update(User t) {
        throw new UnsupportedOperationException("Not supported yet."); //To change body of generated methods, choose Tools | Templates.
    }

    @Override
    public void delete(User t) {
        throw new UnsupportedOperationException("Not supported yet."); //To change body of generated methods, choose Tools | Templates.
    }

    public int vratiMaxID() {

        EntityManager em = emf.createEntityManager();
        em.getTransaction().begin();

        int broj = (int) em.createQuery("SELECT max(u.userID) FROM User u").getSingleResult();

        return broj + 1;
    }

}
