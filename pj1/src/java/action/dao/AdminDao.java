/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package action.dao;

import domen.Admin;
import java.util.List;
import java.util.Optional;
import javax.persistence.EntityManager;
import javax.persistence.EntityManagerFactory;
import javax.persistence.Persistence;

/**
 *
 * @author Pumpkin
 */
public class AdminDao implements Dao<Admin> {

    EntityManagerFactory emf=Persistence.createEntityManagerFactory("pj1PU");;

  
    @Override
    public List<Admin> getAll() {
        EntityManager em = emf.createEntityManager();
        em.getTransaction().begin();

        List<Admin> listaAdmina = em.createQuery("SELECT a FROM Admin a").getResultList();
        return listaAdmina;

    }

    @Override
    public void save(Admin t) {
        throw new UnsupportedOperationException("Not supported yet."); //To change body of generated methods, choose Tools | Templates.
    }

    @Override
    public void update(Admin t) {
        throw new UnsupportedOperationException("Not supported yet."); //To change body of generated methods, choose Tools | Templates.
    }

    @Override
    public void delete(Admin t) {
        throw new UnsupportedOperationException("Not supported yet."); //To change body of generated methods, choose Tools | Templates.
    }

    public Admin findAdmin(String user, String pass) {
        Admin a = new Admin();
        EntityManager em = emf.createEntityManager();
        em.getTransaction().begin();

        List<Admin> listaAdmina = getAll();

        for (Admin admin : listaAdmina) {
            if (admin.getUser().getUsername().equals(user) && admin.getUser().getPassword().equals(pass)) {
                System.out.println("Nasao sam korisnika:" + admin.getUser().getImeIPrezime());
                return admin;

            }
        }
        return null;

      
    }

 

    @Override
   public Admin get(Object... args) {
   String user=(String) args[0];
        String pass=(String) args[1];
         EntityManager em = emf.createEntityManager();
        em.getTransaction().begin();

        List<Admin> listaAdmina = getAll();

        for (Admin admin : listaAdmina) {
            if (admin.getUser().getUsername().equals(user) && admin.getUser().getPassword().equals(pass)) {
                System.out.println("Nasao sam korisnika:" + admin.getUser().getImeIPrezime());
                
                return admin;

            }
        }
        return null;
    }

}
