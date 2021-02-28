package eu.telecom_bretagne.cabinet_recrutement.data.model;

import java.io.Serializable;
import javax.persistence.*;
import java.util.Set;


/**
 * The persistent class for the secteur_activite database table.
 * 
 */
@Entity
@Table(name="secteur_activite")
@NamedQuery(name="SecteurActivite.findAll", query="SELECT s FROM SecteurActivite s")
public class SecteurActivite implements Serializable {
	private static final long serialVersionUID = 1L;

	@Id
	@SequenceGenerator(name="SECTEUR_ACTIVITE_ID_GENERATOR", sequenceName="SECTEUR_ACTIVITE_ID_SEQ", allocationSize=1)
	@GeneratedValue(strategy=GenerationType.SEQUENCE, generator="SECTEUR_ACTIVITE_ID_GENERATOR")
	private Integer id;

	private String intitule;

	//bi-directional many-to-many association to Candidature
	@ManyToMany(fetch=FetchType.EAGER)
	@JoinTable(
		name="detail_candidature"
		, joinColumns={
			@JoinColumn(name="secteur_activite")
			}
		, inverseJoinColumns={
			@JoinColumn(name="candidature")
			}
		)
	private Set<Candidature> candidatures;

	//bi-directional many-to-many association to OffreEmploi
	@ManyToMany(fetch=FetchType.EAGER)
	@JoinTable(
		name="detail_offre_emploi"
		, joinColumns={
			@JoinColumn(name="secteur_activite")
			}
		, inverseJoinColumns={
			@JoinColumn(name="offre_emploi")
			}
		)
	private Set<OffreEmploi> offreEmplois;

	public SecteurActivite() {
	}

	public Integer getId() {
		return this.id;
	}

	public void setId(Integer id) {
		this.id = id;
	}

	public String getIntitule() {
		return this.intitule;
	}

	public void setIntitule(String intitule) {
		this.intitule = intitule;
	}

	public Set<Candidature> getCandidatures() {
		return this.candidatures;
	}

	public void setCandidatures(Set<Candidature> candidatures) {
		this.candidatures = candidatures;
	}
	
	public Candidature addCandidature(Candidature candidature) {
		this.candidatures.add(candidature);
		candidature.getSecteurActivites().add(this);
		return candidature;
	}
	
	public void removeCandidature(Candidature candidature) {
		this.candidatures.remove(candidature);
		candidature.getSecteurActivites().remove(this);
	}

	public Set<OffreEmploi> getOffreEmplois() {
		return this.offreEmplois;
	}

	public void setOffreEmplois(Set<OffreEmploi> offreEmplois) {
		this.offreEmplois = offreEmplois;
	}
	
	public OffreEmploi addOffreEmploi(OffreEmploi offreEmploi) {
		this.offreEmplois.add(offreEmploi);
		offreEmploi.getSecteurActivites().add(this);
		return offreEmploi;
	}
	
	public void removeOffreEmploi(OffreEmploi offreEmploi) {
		offreEmplois.remove(offreEmploi);
		offreEmploi.getSecteurActivites().remove(this);
	}

}
