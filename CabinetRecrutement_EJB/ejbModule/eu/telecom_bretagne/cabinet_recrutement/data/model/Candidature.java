package eu.telecom_bretagne.cabinet_recrutement.data.model;

import java.io.Serializable;
import javax.persistence.*;
import java.util.Date;
import java.util.Set;


/**
 * The persistent class for the candidature database table.
 * 
 */
@Entity
@NamedQuery(name="Candidature.findAll", query="SELECT c FROM Candidature c")
public class Candidature implements Serializable {
	private static final long serialVersionUID = 1L;

	@Id
	@SequenceGenerator(name="CANDIDATURE_ID_GENERATOR", sequenceName="CANDIDATURE_ID_SEQ", allocationSize=1)
	@GeneratedValue(strategy=GenerationType.SEQUENCE, generator="CANDIDATURE_ID_GENERATOR")
	private Integer id;

	private String adresseemail;

	private String adressepostale;

	private String cv;

	@Temporal(TemporalType.DATE)
	private Date datedepot;

	@Temporal(TemporalType.DATE)
	private Date datenaissance;

	private String nom;

	private String prenom;

	//bi-directional many-to-one association to NiveauQualification
	@ManyToOne
	@JoinColumn(name="niveau_qualification")
	private NiveauQualification niveauQualificationBean;

	//bi-directional many-to-one association to MessageCandidature
	@OneToMany(mappedBy="candidatureBean")
	private Set<MessageCandidature> messageCandidatures;

	//bi-directional many-to-one association to MessageOffreDemploi
	@OneToMany(mappedBy="candidatureBean")
	private Set<MessageOffreDemploi> messageOffreDemplois;

	//bi-directional many-to-many association to SecteurActivite
	@ManyToMany(mappedBy="candidatures")
	private Set<SecteurActivite> secteurActivites;

	public Candidature() {
	}

	public Integer getId() {
		return this.id;
	}

	public void setId(Integer id) {
		this.id = id;
	}

	public String getAdresseemail() {
		return this.adresseemail;
	}

	public void setAdresseemail(String adresseemail) {
		this.adresseemail = adresseemail;
	}

	public String getAdressepostale() {
		return this.adressepostale;
	}

	public void setAdressepostale(String adressepostale) {
		this.adressepostale = adressepostale;
	}

	public String getCv() {
		return this.cv;
	}

	public void setCv(String cv) {
		this.cv = cv;
	}

	public Date getDatedepot() {
		return this.datedepot;
	}

	public void setDatedepot(Date datedepot) {
		this.datedepot = datedepot;
	}

	public Date getDatenaissance() {
		return this.datenaissance;
	}

	public void setDatenaissance(Date datenaissance) {
		this.datenaissance = datenaissance;
	}

	public String getNom() {
		return this.nom;
	}

	public void setNom(String nom) {
		this.nom = nom;
	}

	public String getPrenom() {
		return this.prenom;
	}

	public void setPrenom(String prenom) {
		this.prenom = prenom;
	}

	public NiveauQualification getNiveauQualificationBean() {
		return this.niveauQualificationBean;
	}

	public NiveauQualification setNiveauQualificationBean(NiveauQualification niveauQualificationBean) {
		this.niveauQualificationBean = niveauQualificationBean;
		niveauQualificationBean.getCandidatures().add(this);
		return niveauQualificationBean;
	}

	/*public void setNiveauQualificationBean(NiveauQualification niveauQualificationBean) {
		this.niveauQualificationBean = niveauQualificationBean;
	}*/

	public Set<MessageCandidature> getMessageCandidatures() {
		return this.messageCandidatures;
	}

	public void setMessageCandidatures(Set<MessageCandidature> messageCandidatures) {
		this.messageCandidatures = messageCandidatures;
	}

	public MessageCandidature addMessageCandidature(MessageCandidature messageCandidature) {
		this.messageCandidatures.add(messageCandidature);
		messageCandidature.setCandidatureBean(this);
		return messageCandidature;
	}

	public MessageCandidature removeMessageCandidature(MessageCandidature messageCandidature) {
		getMessageCandidatures().remove(messageCandidature);
		messageCandidature.setCandidatureBean(null);

		return messageCandidature;
	}

	/*public MessageCandidature addMessageCandidature(MessageCandidature messageCandidature) {
		getMessageCandidatures().add(messageCandidature);
		messageCandidature.setCandidatureBean(this);

		return messageCandidature;
	}

	public MessageCandidature removeMessageCandidature(MessageCandidature messageCandidature) {
		getMessageCandidatures().remove(messageCandidature);
		messageCandidature.setCandidatureBean(null);

		return messageCandidature;
	}*/

	public Set<MessageOffreDemploi> getMessageOffreDemplois() {
		return this.messageOffreDemplois;
	}

	public void setMessageOffreDemplois(Set<MessageOffreDemploi> messageOffreDemplois) {
		this.messageOffreDemplois = messageOffreDemplois;
	}

	public MessageOffreDemploi addMessageOffreDemploi(MessageOffreDemploi messageOffreDemploi) {
		this.messageOffreDemplois.add(messageOffreDemploi);
		messageOffreDemploi.setCandidatureBean(this);
		return messageOffreDemploi;
	}

	public void removeMessageOffreDemploi(MessageOffreDemploi messageOffreDemploi) {
		this.messageOffreDemplois.remove(messageOffreDemploi);
		messageOffreDemploi.setCandidatureBean(null);
	}

	/*public MessageOffreDemploi addMessageOffreDemploi(MessageOffreDemploi messageOffreDemploi) {
		getMessageOffreDemplois().add(messageOffreDemploi);
		messageOffreDemploi.setCandidatureBean(this);

		return messageOffreDemploi;
	}

	public MessageOffreDemploi removeMessageOffreDemploi(MessageOffreDemploi messageOffreDemploi) {
		getMessageOffreDemplois().remove(messageOffreDemploi);
		messageOffreDemploi.setCandidatureBean(null);

		return messageOffreDemploi;
	}*/

	public Set<SecteurActivite> getSecteurActivites() {
		return this.secteurActivites;
	}

	public void setSecteurActivites(Set<SecteurActivite> secteurActivites) {
		this.secteurActivites = secteurActivites;
	}
	
		public SecteurActivite addSecteurActivite(SecteurActivite secteurActivite) {
		this.secteurActivites.add(secteurActivite);
		secteurActivite.getCandidatures().add(this);
		return secteurActivite;
	}
	
		public SecteurActivite removeSecteurActivite(SecteurActivite secteurActivite) {
		this.secteurActivites.remove(secteurActivite);
		secteurActivite.getCandidatures().remove(this);
		return secteurActivite;
	}

}
