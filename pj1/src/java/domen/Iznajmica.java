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
import javax.persistence.ManyToOne;
import javax.persistence.NamedQueries;
import javax.persistence.NamedQuery;
import javax.persistence.Table;
import javax.persistence.Temporal;
import javax.persistence.TemporalType;
import javax.xml.bind.annotation.XmlRootElement;

/**
 *
 * @author Pumpkin
 */
@Entity
@Table(name = "iznajmica")
@XmlRootElement
@NamedQueries({
    @NamedQuery(name = "Iznajmica.findAll", query = "SELECT i FROM Iznajmica i"),
    @NamedQuery(name = "Iznajmica.findByIznajmicaID", query = "SELECT i FROM Iznajmica i WHERE i.iznajmicaID = :iznajmicaID"),
    @NamedQuery(name = "Iznajmica.findByDatumIzdavanja", query = "SELECT i FROM Iznajmica i WHERE i.datumIzdavanja = :datumIzdavanja"),
    @NamedQuery(name = "Iznajmica.findByDatumPovracaja", query = "SELECT i FROM Iznajmica i WHERE i.datumPovracaja = :datumPovracaja")})
public class Iznajmica implements Serializable {
    private static final long serialVersionUID = 1L;
    @Id
    @Basic(optional = false)
    @Column(name = "iznajmicaID")
    private Integer iznajmicaID;
    @Column(name = "DatumIzdavanja")
    @Temporal(TemporalType.TIMESTAMP)
    private Date datumIzdavanja;
    @Column(name = "DatumPovracaja")
    @Temporal(TemporalType.TIMESTAMP)
    private Date datumPovracaja;
    @JoinColumn(name = "KnjigaID", referencedColumnName = "knjigaID")
    @ManyToOne(optional = false)
    private Knjiga knjigaID;
    @JoinColumn(name = "KorisnikID", referencedColumnName = "korisnikID")
    @ManyToOne(optional = false)
    private Korisnik korisnikID;

    public Iznajmica() {
    }

    public Iznajmica(Integer iznajmicaID) {
        this.iznajmicaID = iznajmicaID;
    }

    public Iznajmica(Integer iznajmicaID, Date datumIzdavanja, Date datumPovracaja, Knjiga knjigaID, Korisnik korisnikID) {
        this.iznajmicaID = iznajmicaID;
        this.datumIzdavanja = datumIzdavanja;
        this.datumPovracaja = datumPovracaja;
        this.knjigaID = knjigaID;
        this.korisnikID = korisnikID;
    }
    

    public Integer getIznajmicaID() {
        return iznajmicaID;
    }

    public void setIznajmicaID(Integer iznajmicaID) {
        this.iznajmicaID = iznajmicaID;
    }

    public Date getDatumIzdavanja() {
        return datumIzdavanja;
    }

    public void setDatumIzdavanja(Date datumIzdavanja) {
        this.datumIzdavanja = datumIzdavanja;
    }

    public Date getDatumPovracaja() {
        return datumPovracaja;
    }

    public void setDatumPovracaja(Date datumPovracaja) {
        this.datumPovracaja = datumPovracaja;
    }

    public Knjiga getKnjigaID() {
        return knjigaID;
    }

    public void setKnjigaID(Knjiga knjigaID) {
        this.knjigaID = knjigaID;
    }

    public Korisnik getKorisnikID() {
        return korisnikID;
    }

    public void setKorisnikID(Korisnik korisnikID) {
        this.korisnikID = korisnikID;
    }

    @Override
    public int hashCode() {
        int hash = 0;
        hash += (iznajmicaID != null ? iznajmicaID.hashCode() : 0);
        return hash;
    }

    @Override
    public boolean equals(Object object) {
        // TODO: Warning - this method won't work in the case the id fields are not set
        if (!(object instanceof Iznajmica)) {
            return false;
        }
        Iznajmica other = (Iznajmica) object;
        if ((this.iznajmicaID == null && other.iznajmicaID != null) || (this.iznajmicaID != null && !this.iznajmicaID.equals(other.iznajmicaID))) {
            return false;
        }
        return true;
    }

    @Override
    public String toString() {
        return "domen.Iznajmica[ iznajmicaID=" + iznajmicaID + " ]";
    }
    
}
