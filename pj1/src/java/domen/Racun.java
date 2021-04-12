/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package domen;

import java.io.Serializable;
import java.util.Date;
import java.util.List;
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
import javax.persistence.OneToMany;
import javax.persistence.Table;
import javax.persistence.Temporal;
import javax.persistence.TemporalType;
import javax.xml.bind.annotation.XmlRootElement;
import javax.xml.bind.annotation.XmlTransient;

/**
 *
 * @author Pumpkin
 */
@Entity
@Table(name = "racun")
@XmlRootElement
@NamedQueries({
    @NamedQuery(name = "Racun.findAll", query = "SELECT r FROM Racun r"),
    @NamedQuery(name = "Racun.findByRacunID", query = "SELECT r FROM Racun r WHERE r.racunID = :racunID"),
    @NamedQuery(name = "Racun.findByVreme", query = "SELECT r FROM Racun r WHERE r.vreme = :vreme"),
    @NamedQuery(name = "Racun.findByPopust", query = "SELECT r FROM Racun r WHERE r.popust = :popust"),
    @NamedQuery(name = "Racun.findByIznos", query = "SELECT r FROM Racun r WHERE r.iznos = :iznos")})
public class Racun implements Serializable {
    private static final long serialVersionUID = 1L;
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Basic(optional = false)
    @Column(name = "racunID")
    private Integer racunID;
    @Column(name = "Vreme")
    @Temporal(TemporalType.TIMESTAMP)
    private Date vreme;
    // @Max(value=?)  @Min(value=?)//if you know range of your decimal fields consider using these annotations to enforce field validation
    @Column(name = "Popust")
    private Double popust;
    @Column(name = "Iznos")
    private Double iznos;
    @OneToMany(mappedBy = "racun")
    private List<Stavkaracuna> stavkaracunaList;
    @JoinColumn(name = "kupacID", referencedColumnName = "korisnikID")
    @ManyToOne
    private Korisnik kupacID;

    public Racun() {
    }

    public Racun(Integer racunID, Date vreme, Double popust, Double iznos, List<Stavkaracuna> stavkaracunaList, Korisnik kupacID) {
        this.racunID = racunID;
        this.vreme = vreme;
        this.popust = popust;
        this.iznos = iznos;
        this.stavkaracunaList = stavkaracunaList;
        this.kupacID = kupacID;
    }

    public Racun(Integer racunID) {
        this.racunID = racunID;
    }

    public Integer getRacunID() {
        return racunID;
    }

    public void setRacunID(Integer racunID) {
        this.racunID = racunID;
    }

    public Date getVreme() {
        return vreme;
    }

    public void setVreme(Date vreme) {
        this.vreme = vreme;
    }

    public Double getPopust() {
        return popust;
    }

    public void setPopust(Double popust) {
        this.popust = popust;
    }

    public Double getIznos() {
        return iznos;
    }

    public void setIznos(Double iznos) {
        this.iznos = iznos;
    }

    @XmlTransient
    public List<Stavkaracuna> getStavkaracunaList() {
        return stavkaracunaList;
    }

    public void setStavkaracunaList(List<Stavkaracuna> stavkaracunaList) {
        this.stavkaracunaList = stavkaracunaList;
    }

    public Korisnik getKupacID() {
        return kupacID;
    }

    public void setKupacID(Korisnik kupacID) {
        this.kupacID = kupacID;
    }

    @Override
    public int hashCode() {
        int hash = 0;
        hash += (racunID != null ? racunID.hashCode() : 0);
        return hash;
    }

    @Override
    public boolean equals(Object object) {
        // TODO: Warning - this method won't work in the case the id fields are not set
        if (!(object instanceof Racun)) {
            return false;
        }
        Racun other = (Racun) object;
        if ((this.racunID == null && other.racunID != null) || (this.racunID != null && !this.racunID.equals(other.racunID))) {
            return false;
        }
        return true;
    }

    @Override
    public String toString() {
        return "domen.Racun[ racunID=" + racunID + " ]";
    }
    
}
