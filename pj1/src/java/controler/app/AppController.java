/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package controler.app;

import action.AbstractAction;
import action.ActionFactory;
import javax.servlet.http.HttpServletRequest;

/**
 *
 * @author Stefan
 */
public class AppController {
    private static AppController instance;

    private AppController() {
    }

    public static AppController getInstance() {
        if (instance == null) {
            instance = new AppController();
        }
        return instance;
    }
    
    public String obradiZahtev(String action, HttpServletRequest request) {
        String page = "index";
        
        AbstractAction command = ActionFactory.napraviAkciju(action);
        page = command.izvrsi(request);
        
        return page;
    }

}

