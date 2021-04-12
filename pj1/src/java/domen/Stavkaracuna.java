/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package domen;

import java.io.Serializable;
import javax.persistence.Basic;
import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.JoinColumn;
import javax.persistence.ManyToOne;
import javax.persistence.NamedQueries;
import javax.persistence.NamedQuery;
import javax.persistence.Table;
import javax.xml.bind.annotation.XmlRootElement;

/**
 *
 * @author Pumpkin
 */
@Entity
@Table(name = "stavkaracuna")
@XmlRootElement
@NamedQueries({
    @NamedQuery(name = "Stavkaracuna.findAll", query = "SELECT s FROM Stavkaracuna s"),
    @NamedQuery(name = "Stavkaracuna.findByStavkaRacunaID", query = "SELECT s FROM Stavkaracuna s WHERE s.stavkaRacunaID = :stavkaRacunaID"),
    @NamedQuery(name = "Stavkaracuna.findByNazivKnjige", query = "SELECT s FROM Stavkaracuna s WHERE s.nazivKnjige = :nazivKnjige"),
    @NamedQuery(name = "Stavkaracuna.findByCena", query = "SELECT s FROM Stavkaracuna s WHERE s.cena = :cena")})
public class Stavkaracuna implements Serializable {
    private static final long serialVersionUID = 1L;
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Basic(optional = false)
    @Column(name = "stavkaRacunaID")
    private Integer stavkaRacunaID;
    @Column(name = "NazivKnjige")
    private String nazivKnjige;
    // @Max(value=?)  @Min(value=?)//if you know range of your decimal fields consider using these annotations to enforce field validation
    @Column(name = "Cena")
    private Double cena;
    @JoinColumn(name = "racun", referencedColumnName = "racunID")
    @ManyToOne
    private Racun racun;

    public Stavkaracuna() {
    }

    public Stavkaracuna(Integer stavkaRacunaID, String nazivKnjige, Double cena, Racun racun) {
        this.stavkaRacunaID = stavkaRacunaID;
        this.nazivKnjige = nazivKnjige;
        this.cena = cena;
        this.racun = racun;
    }
    

    public Stavkaracuna(Integer stavkaRacunaID) {
        this.stavkaRacunaID = stavkaRacunaID;
    }

    public Integer getStavkaRacunaID() {
        return stavkaRacunaID;
    }

    public void setStavkaRacunaID(Integer stavkaRacunaID) {
        this.stavkaRacunaID = stavkaRacunaID;
    }

    public String getNazivKnjige() {
        return nazivKnjige;
    }

    public void setNazivKnjige(String nazivKnjige) {
        this.nazivKnjige = nazivKnjige;
    }

    public Double getCena() {
        return cena;
    }

    public void setCena(Double cena) {
        this.cena = cena;
    }

    public Racun getRacun() {
        return racun;
    }

    public void setRacun(Racun racun) {
        this.racun = racun;
    }

    @Override
    public int hashCode() {
        int hash = 0;
        hash += (stavkaRacunaID != null ? stavkaRacunaID.hashCode() : 0);
        return hash;
    }

    @Override
    public boolean equals(Object object) {
        // TODO: Warning - this method won't work in the case the id fields are not set
        if (!(object instanceof Stavkaracuna)) {
            return false;
        }
        Stavkaracuna other = (Stavkaracuna) object;
        if ((this.stavkaRacunaID == null && other.stavkaRacunaID != null) || (this.stavkaRacunaID != null && !this.stavkaRacunaID.equals(other.stavkaRacunaID))) {
            return false;
        }
        return true;
    }

    @Override
    public String toString() {
        return getNazivKnjige()+"-"+getCena()+" ";
    }
    
}
