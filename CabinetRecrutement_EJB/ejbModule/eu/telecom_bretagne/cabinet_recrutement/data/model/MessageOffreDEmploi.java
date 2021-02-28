package eu.telecom_bretagne.cabinet_recrutement.data.model;

import java.io.Serializable;
import javax.persistence.*;
import java.util.Date;


/**
 * The persistent class for the message_offre_demploi database table.
 * 
 */
@Entity
@Table(name="message_offre_demploi")
@NamedQuery(name="MessageOffreDEmploi.findAll", query="SELECT m FROM MessageOffreDEmploi m")
public class MessageOffreDEmploi implements Serializable {
	private static final long serialVersionUID = 1L;

	@Id
	@SequenceGenerator(name="MESSAGE_OFFRE_DEMPLOI_ID_GENERATOR", sequenceName="MESSAGE_OFFRE_DEMPLOI_ID_SEQ", allocationSize=1)
	@GeneratedValue(strategy=GenerationType.SEQUENCE, generator="MESSAGE_OFFRE_DEMPLOI_ID_GENERATOR")
	private Integer id;

	private String corpsmessage;

	@Temporal(TemporalType.DATE)
	private Date dateenvoi;

	//bi-directional many-to-one association to Candidature
	@ManyToOne(fetch=FetchType.EAGER)
	@JoinColumn(name="candidature")
	private Candidature candidatureBean;

	//bi-directional many-to-one association to OffreEmploi
	@ManyToOne(fetch=FetchType.EAGER)
	@JoinColumn(name="offre_emploi")
	private OffreEmploi offreEmploiBean;

	public MessageOffreDEmploi() {
	}

	public Integer getId() {
		return this.id;
	}

	public void setId(Integer id) {
		this.id = id;
	}

	public String getCorpsmessage() {
		return this.corpsmessage;
	}

	public void setCorpsmessage(String corpsmessage) {
		this.corpsmessage = corpsmessage;
	}

	public Date getDateenvoi() {
		return this.dateenvoi;
	}

	public void setDateenvoi(Date dateenvoi) {
		this.dateenvoi = dateenvoi;
	}

	public Candidature getCandidatureBean() {
		return this.candidatureBean;
	}

	public Candidature setCandidatureBean(Candidature candidatureBean) {
		this.candidatureBean = candidatureBean;
		candidatureBean.getMessageOffreDemplois().add(this);
		return candidatureBean;
	}

	public OffreEmploi getOffreEmploiBean() {
		return this.offreEmploiBean;
	}

	public OffreEmploi setOffreEmploiBean(OffreEmploi offreEmploiBean) {
		this.offreEmploiBean = offreEmploiBean;
		offreEmploiBean.getMessageOffreDemplois().add(this);
		return offreEmploiBean;
	}

}