/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package domen;

import java.io.Serializable;
import java.util.Date;
import javax.persistence.Basic;
import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.Id;
import javax.persistence.JoinColumn;
import javax.persistence.NamedQueries;
import javax.persistence.NamedQuery;
import javax.persistence.OneToOne;
import javax.persistence.Table;
import javax.persistence.Temporal;
import javax.persistence.TemporalType;
import javax.xml.bind.annotation.XmlRootElement;

/**
 *
 * @author Pumpkin
 */
@Entity
@Table(name = "korisnik")
@XmlRootElement
@NamedQueries({
    @NamedQuery(name = "Korisnik.findAll", query = "SELECT k FROM Korisnik k"),
    @NamedQuery(name = "Korisnik.findByKorisnikID", query = "SELECT k FROM Korisnik k WHERE k.korisnikID = :korisnikID"),
    @NamedQuery(name = "Korisnik.findByERacun", query = "SELECT k FROM Korisnik k WHERE k.eRacun = :eRacun"),
    @NamedQuery(name = "Korisnik.findByDatumRodjenja", query = "SELECT k FROM Korisnik k WHERE k.datumRodjenja = :datumRodjenja"),
    @NamedQuery(name = "Korisnik.findByDatumRegistracije", query = "SELECT k FROM Korisnik k WHERE k.datumRegistracije = :datumRegistracije")})
public class Korisnik implements Serializable {
    private static final long serialVersionUID = 1L;
    @Id
    @Basic(optional = false)
    @Column(name = "korisnikID")
    private Integer korisnikID;
    @Column(name = "ERacun")
    private String eRacun;
    @Column(name = "DatumRodjenja")
    @Temporal(TemporalType.TIMESTAMP)
    private Date datumRodjenja;
    @Column(name = "DatumRegistracije")
    @Temporal(TemporalType.TIMESTAMP)
    private Date datumRegistracije;
    @JoinColumn(name = "korisnikID", referencedColumnName = "userID", insertable = false, updatable = false)
    @OneToOne(optional = false)
    private User user;

    public Korisnik() {
    }

    public Korisnik(Integer korisnikID, String eRacun, Date datumRodjenja, Date datumRegistracije, User user) {
        this.korisnikID = korisnikID;
        this.eRacun = eRacun;
        this.datumRodjenja = datumRodjenja;
        this.datumRegistracije = datumRegistracije;
        this.user = user;
    }

    
    public Korisnik(Integer korisnikID) {
        this.korisnikID = korisnikID;
    }

    public Integer getKorisnikID() {
        return korisnikID;
    }

    public void setKorisnikID(Integer korisnikID) {
        this.korisnikID = korisnikID;
    }

    public String getERacun() {
        return eRacun;
    }

    public void setERacun(String eRacun) {
        this.eRacun = eRacun;
    }

    public Date getDatumRodjenja() {
        return datumRodjenja;
    }

    public void setDatumRodjenja(Date datumRodjenja) {
        this.datumRodjenja = datumRodjenja;
    }

    public Date getDatumRegistracije() {
        return datumRegistracije;
    }

    public void setDatumRegistracije(Date datumRegistracije) {
        this.datumRegistracije = datumRegistracije;
    }

    public User getUser() {
        return user;
    }

    public void setUser(User user) {
        this.user = user;
    }

    @Override
    public int hashCode() {
        int hash = 0;
        hash += (korisnikID != null ? korisnikID.hashCode() : 0);
        return hash;
    }

    @Override
    public boolean equals(Object object) {
        // TODO: Warning - this method won't work in the case the id fields are not set
        if (!(object instanceof Korisnik)) {
            return false;
        }
        Korisnik other = (Korisnik) object;
        if ((this.korisnikID == null && other.korisnikID != null) || (this.korisnikID != null && !this.korisnikID.equals(other.korisnikID))) {
            return false;
        }
        return true;
    }

    @Override
    public String toString() {
        return "domen.Korisnik[ korisnikID=" + korisnikID + " ]";
    }
    
}
