/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package domen;

import java.io.Serializable;
import java.util.List;
import javax.persistence.Basic;
import javax.persistence.CascadeType;
import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.JoinColumn;
import javax.persistence.JoinTable;
import javax.persistence.ManyToMany;
import javax.persistence.NamedQueries;
import javax.persistence.NamedQuery;
import javax.persistence.OneToMany;
import javax.persistence.Table;
import javax.xml.bind.annotation.XmlRootElement;
import javax.xml.bind.annotation.XmlTransient;

/**
 *
 * @author Pumpkin
 */
@Entity
@Table(name = "knjiga")
@XmlRootElement
@NamedQueries({
    @NamedQuery(name = "Knjiga.findAll", query = "SELECT k FROM Knjiga k"),
    @NamedQuery(name = "Knjiga.findByKnjigaID", query = "SELECT k FROM Knjiga k WHERE k.knjigaID = :knjigaID"),
    @NamedQuery(name = "Knjiga.findByPisac", query = "SELECT k FROM Knjiga k WHERE k.pisac = :pisac"),
    @NamedQuery(name = "Knjiga.findByIzdavac", query = "SELECT k FROM Knjiga k WHERE k.izdavac = :izdavac"),
    @NamedQuery(name = "Knjiga.findByNaziv", query = "SELECT k FROM Knjiga k WHERE k.naziv = :naziv"),
    @NamedQuery(name = "Knjiga.findByGodinaIzdavanja", query = "SELECT k FROM Knjiga k WHERE k.godinaIzdavanja = :godinaIzdavanja"),
    @NamedQuery(name = "Knjiga.findByOpis", query = "SELECT k FROM Knjiga k WHERE k.opis = :opis"),
    @NamedQuery(name = "Knjiga.findByCena", query = "SELECT k FROM Knjiga k WHERE k.cena = :cena"),
    @NamedQuery(name = "Knjiga.findByStanjeNaLageru", query = "SELECT k FROM Knjiga k WHERE k.stanjeNaLageru = :stanjeNaLageru"),
    @NamedQuery(name = "Knjiga.findByStatus", query = "SELECT k FROM Knjiga k WHERE k.status = :status")})
public class Knjiga implements Serializable {
    @OneToMany(cascade = CascadeType.ALL, mappedBy = "knjigaID")
    private List<Iznajmica> iznajmicaList;
    private static final long serialVersionUID = 1L;
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Basic(optional = false)
    @Column(name = "knjigaID")
    private Integer knjigaID;
    @Column(name = "Pisac")
    private String pisac;
    @Column(name = "Izdavac")
    private String izdavac;
    @Column(name = "Naziv")
    private String naziv;
    @Column(name = "GodinaIzdavanja")
    private Integer godinaIzdavanja;
    @Column(name = "Opis")
    private String opis;
    // @Max(value=?)  @Min(value=?)//if you know range of your decimal fields consider using these annotations to enforce field validation
    @Column(name = "Cena")
    private Double cena;
    @Column(name = "StanjeNaLageru")
    private Integer stanjeNaLageru;
    @Column(name = "Status")
    private String status;
    @JoinTable(name = "zanrovi_za_knjigu", joinColumns = {
        @JoinColumn(name = "knjigaID", referencedColumnName = "knjigaID")}, inverseJoinColumns = {
        @JoinColumn(name = "zanrID", referencedColumnName = "zanrID")})
    @ManyToMany
    private List<Zanr> zanrList;

      public String getZanrToString(){
        String zanr1="";
        for(Zanr z: getZanrList()){
            zanr1+=z.getNaziv()+", ";
        }
        if(zanr1.length()>3)
            return zanr1.substring(0, zanr1.length()-2);
        return zanr1;
    }
    public Knjiga() {
    }

    public Knjiga(Integer knjigaID) {
        this.knjigaID = knjigaID;
    }

    public Integer getKnjigaID() {
        return knjigaID;
    }

    public void setKnjigaID(Integer knjigaID) {
        this.knjigaID = knjigaID;
    }

    public String getPisac() {
        return pisac;
    }

    public void setPisac(String pisac) {
        this.pisac = pisac;
    }

    public String getIzdavac() {
        return izdavac;
    }

    public void setIzdavac(String izdavac) {
        this.izdavac = izdavac;
    }

    public String getNaziv() {
        return naziv;
    }

    public void setNaziv(String naziv) {
        this.naziv = naziv;
    }

    public Integer getGodinaIzdavanja() {
        return godinaIzdavanja;
    }

    public void setGodinaIzdavanja(Integer godinaIzdavanja) {
        this.godinaIzdavanja = godinaIzdavanja;
    }

    public String getOpis() {
        return opis;
    }

    public void setOpis(String opis) {
        this.opis = opis;
    }

    public Double getCena() {
        return cena;
    }

    public void setCena(Double cena) {
        this.cena = cena;
    }

    public Integer getStanjeNaLageru() {
        return stanjeNaLageru;
    }

    public void setStanjeNaLageru(Integer stanjeNaLageru) {
        this.stanjeNaLageru = stanjeNaLageru;
    }

    public String getStatus() {
        return status;
    }

    public void setStatus(String status) {
        this.status = status;
    }

    @XmlTransient
    public List<Zanr> getZanrList() {
        return zanrList;
    }

    public void setZanrList(List<Zanr> zanrList) {
        this.zanrList = zanrList;
    }

    @Override
    public int hashCode() {
        int hash = 0;
        hash += (knjigaID != null ? knjigaID.hashCode() : 0);
        return hash;
    }

    @Override
    public boolean equals(Object object) {
        // TODO: Warning - this method won't work in the case the id fields are not set
        if (!(object instanceof Knjiga)) {
            return false;
        }
        Knjiga other = (Knjiga) object;
        if ((this.knjigaID == null && other.knjigaID != null) || (this.knjigaID != null && !this.knjigaID.equals(other.knjigaID))) {
            return false;
        }
        return true;
    }

    @Override
    public String toString() {
        return "domen.Knjiga[ knjigaID=" + knjigaID + " ]";
    }

    @XmlTransient
    public List<Iznajmica> getIznajmicaList() {
        return iznajmicaList;
    }

    public void setIznajmicaList(List<Iznajmica> iznajmicaList) {
        this.iznajmicaList = iznajmicaList;
    }
    
}
