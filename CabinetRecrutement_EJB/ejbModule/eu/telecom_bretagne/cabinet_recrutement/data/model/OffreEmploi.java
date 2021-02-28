package eu.telecom_bretagne.cabinet_recrutement.data.model;

import java.io.Serializable;
import javax.persistence.*;

import java.util.ArrayList;
import java.util.Date;
import java.util.List;
import java.util.Set;


/**
 * The persistent class for the offre_emploi database table.
 * 
 */
@Entity
@Table(name="offre_emploi")
@NamedQuery(name="OffreEmploi.findAll", query="SELECT o FROM OffreEmploi o")
public class OffreEmploi implements Serializable {
	private static final long serialVersionUID = 1L;

	@Id
	@SequenceGenerator(name="OFFRE_EMPLOI_ID_GENERATOR", sequenceName="OFFRE_EMPLOI_ID_SEQ", allocationSize=1)
	@GeneratedValue(strategy=GenerationType.SEQUENCE, generator="OFFRE_EMPLOI_ID_GENERATOR")
	private Integer id;

	@Temporal(TemporalType.DATE)
	private Date datedepot;

	private String descriptifmission;

	private String profilrecherche;

	private String titre;

	//bi-directional many-to-one association to MessageCandidature
	@OneToMany(mappedBy="offreEmploiBean")
	private Set<MessageCandidature> messageCandidatures;

	//bi-directional many-to-one association to MessageOffreDemploi
	@OneToMany(mappedBy="offreEmploiBean")
	private Set<MessageOffreDEmploi> messageOffreDemplois;

	//bi-directional many-to-one association to Entreprise
	@ManyToOne
	@JoinColumn(name="entreprise")
	private Entreprise entrepriseBean;

	//bi-directional many-to-one association to NiveauQualification
	@ManyToOne
	@JoinColumn(name="niveau_qualification")
	private NiveauQualification niveauQualificationBean;

	//bi-directional many-to-many association to SecteurActivite
	@ManyToMany(mappedBy="offreEmplois")
	private Set<SecteurActivite> secteurActivites;

	public OffreEmploi() {
	}

	public Integer getId() {
		return this.id;
	}

	public void setId(Integer id) {
		this.id = id;
	}

	public Date getDatedepot() {
		return this.datedepot;
	}

	public void setDatedepot(Date datedepot) {
		this.datedepot = datedepot;
	}

	public String getDescriptifmission() {
		return this.descriptifmission;
	}

	public void setDescriptifmission(String descriptifmission) {
		this.descriptifmission = descriptifmission;
	}

	public String getProfilrecherche() {
		return this.profilrecherche;
	}

	public void setProfilrecherche(String profilrecherche) {
		this.profilrecherche = profilrecherche;
	}

	public String getTitre() {
		return this.titre;
	}

	public void setTitre(String titre) {
		this.titre = titre;
	}

	public Set<MessageCandidature> getMessageCandidatures() {
		return this.messageCandidatures;
	}

	public void setMessageCandidatures(Set<MessageCandidature> messageCandidatures) {
		this.messageCandidatures = messageCandidatures;
	}

	public MessageCandidature addMessageCandidature(MessageCandidature messageCandidature) {
		this.messageCandidatures.add(messageCandidature);
		messageCandidature.setOffreEmploiBean(this);
		return messageCandidature;
	}
	
	public void removeMessageCandidature(MessageCandidature messageCandidature) {
		this.messageCandidatures.remove(messageCandidature);
		messageCandidature.setCandidatureBean(null);
	}

	/*public MessageCandidature addMessageCandidature(MessageCandidature messageCandidature) {
		getMessageCandidatures().add(messageCandidature);
		messageCandidature.setOffreEmploiBean(this);

		return messageCandidature;
	}

	public MessageCandidature removeMessageCandidature(MessageCandidature messageCandidature) {
		getMessageCandidatures().remove(messageCandidature);
		messageCandidature.setOffreEmploiBean(null);

		return messageCandidature;
	}*/

	public Set<MessageOffreDEmploi> getMessageOffreDemplois() {
		return this.messageOffreDemplois;
	}

	public void setMessageOffreDemplois(Set<MessageOffreDEmploi> messageOffreDemplois) {
		this.messageOffreDemplois = messageOffreDemplois;
	}
	
	public MessageOffreDEmploi addMessageOffreDemploi(MessageOffreDEmploi messageOffreDemploi) {
		this.messageOffreDemplois.add(messageOffreDemploi);
		messageOffreDemploi.setOffreEmploiBean(this);
		return messageOffreDemploi;
	}
	
	public void removeMessageOffreDemploi(MessageOffreDEmploi messageOffreDemploi) {
		this.messageOffreDemplois.remove(messageOffreDemploi);
		messageOffreDemploi.setOffreEmploiBean(null);
	}

	/*public MessageOffreDemploi addMessageOffreDemploi(MessageOffreDemploi messageOffreDemploi) {
		getMessageOffreDemplois().add(messageOffreDemploi);
		messageOffreDemploi.setOffreEmploiBean(this);

		return messageOffreDemploi;
	}

	public MessageOffreDemploi removeMessageOffreDemploi(MessageOffreDemploi messageOffreDemploi) {
		getMessageOffreDemplois().remove(messageOffreDemploi);
		messageOffreDemploi.setOffreEmploiBean(null);

		return messageOffreDemploi;
	}*/

	public Entreprise getEntrepriseBean() {
		return this.entrepriseBean;
	}

	public Entreprise setEntrepriseBean(Entreprise entrepriseBean) {
		this.entrepriseBean = entrepriseBean;
		entrepriseBean.getOffreEmplois().add(this);
		return entrepriseBean;
	}

	public NiveauQualification getNiveauQualificationBean() {
		return this.niveauQualificationBean;
	}

	public List<NiveauQualification> setNiveauQualificationBean(NiveauQualification niveauQualificationBean) {
		List<NiveauQualification> nvxQualification = new ArrayList<>();
		NiveauQualification nQ = this.getNiveauQualificationBean();
		if(nQ != null) {
			nQ.removeOffreEmploi(this);
			nvxQualification.add(nQ);
		}
		this.niveauQualificationBean = niveauQualificationBean;
		niveauQualificationBean.getOffreEmplois().add(this);
		return nvxQualification;
	}

	/*public void setNiveauQualificationBean(NiveauQualification niveauQualificationBean) {
		this.niveauQualificationBean = niveauQualificationBean;
	}*/

	public Set<SecteurActivite> getSecteurActivites() {
		return this.secteurActivites;
	}

	public void setSecteurActivites(Set<SecteurActivite> secteurActivites) {
		this.secteurActivites = secteurActivites;
	}
	
	public SecteurActivite addSecteurActivite(SecteurActivite secteurActivite) {
		this.secteurActivites.add(secteurActivite);
		secteurActivite.getOffreEmplois().add(this);
		return secteurActivite;
	}
	
	public void removeSecteurActivite(SecteurActivite secteurActivite) {
		this.secteurActivites.remove(secteurActivite);
		secteurActivite.getOffreEmplois().remove(this);
	}

}
