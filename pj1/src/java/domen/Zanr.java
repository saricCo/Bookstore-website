/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package domen;

import java.io.Serializable;
import java.util.List;
import javax.persistence.Basic;
import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.ManyToMany;
import javax.persistence.NamedQueries;
import javax.persistence.NamedQuery;
import javax.persistence.Table;
import javax.xml.bind.annotation.XmlRootElement;
import javax.xml.bind.annotation.XmlTransient;

/**
 *
 * @author Pumpkin
 */
@Entity
@Table(name = "zanr")
@XmlRootElement
@NamedQueries({
    @NamedQuery(name = "Zanr.findAll", query = "SELECT z FROM Zanr z"),
    @NamedQuery(name = "Zanr.findByZanrID", query = "SELECT z FROM Zanr z WHERE z.zanrID = :zanrID"),
    @NamedQuery(name = "Zanr.findByNaziv", query = "SELECT z FROM Zanr z WHERE z.naziv = :naziv")})
public class Zanr implements Serializable {
    @ManyToMany(mappedBy = "zanrList")
    private List<Knjiga> knjigaList;
    private static final long serialVersionUID = 1L;
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Basic(optional = false)
    @Column(name = "zanrID")
    private Integer zanrID;
    @Column(name = "Naziv")
    private String naziv;

    public Zanr() {
    }
    

    public Zanr(Integer zanrID, String naziv) {
        this.zanrID = zanrID;
        this.naziv=naziv;
    }

    public Integer getZanrID() {
        return zanrID;
    }

    public void setZanrID(Integer zanrID) {
        this.zanrID = zanrID;
    }

    public String getNaziv() {
        return naziv;
    }

    public void setNaziv(String naziv) {
        this.naziv = naziv;
    }

    @Override
    public int hashCode() {
        int hash = 0;
        hash += (zanrID != null ? zanrID.hashCode() : 0);
        return hash;
    }

    @Override
    public boolean equals(Object object) {
        // TODO: Warning - this method won't work in the case the id fields are not set
        if (!(object instanceof Zanr)) {
            return false;
        }
        Zanr other = (Zanr) object;
        if ((this.zanrID == null && other.zanrID != null) || (this.zanrID != null && !this.zanrID.equals(other.zanrID))) {
            return false;
        }
        return true;
    }

    @Override
    public String toString() {
     return getNaziv()+", ";
    }

    @XmlTransient
    public List<Knjiga> getKnjigaList() {
        return knjigaList;
    }

    public void setKnjigaList(List<Knjiga> knjigaList) {
        this.knjigaList = knjigaList;
    }
    
}
