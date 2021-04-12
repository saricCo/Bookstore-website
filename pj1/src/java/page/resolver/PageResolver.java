    /*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package page.resolver;

import java.util.HashMap;
import java.util.Map;

/**
 *
 * @author Pumpkin
 */
public class PageResolver {

    private static PageResolver instance;
    private Map<String, String> mapa;

    private PageResolver() {
        mapa = new HashMap<>();
        mapa.put("dodaj_knjigu", "//WEB-INF/pages/dodaj_knjigu.jsp");
        mapa.put("index", "/index.jsp");
        mapa.put("korpa", "//WEB-INF/pages/korpa.jsp");
        mapa.put("racuni", "/WEB-INF/pages/racuni.jsp");
        mapa.put("iznajmljeneKnjige","/WEB-INF/pages/iznajmljene_knjige.jsp");

    }

    public static PageResolver getInstance() {
        if (instance == null) {
            instance = new PageResolver();
        }
        return instance;
    }

    public String getPage(String key) {
        return mapa.get(key);
    }
}
