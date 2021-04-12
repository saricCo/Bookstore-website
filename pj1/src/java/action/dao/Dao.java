/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package action.dao;

import java.util.List;
import java.util.Optional;

/**
 *
 * @author Pumpkin
 */
public interface Dao<T> {
     
    T get(Object... args);
     
    List<T> getAll();
     
    void save(T t);
     
    void update(T t);
     
    void delete(T t);
}