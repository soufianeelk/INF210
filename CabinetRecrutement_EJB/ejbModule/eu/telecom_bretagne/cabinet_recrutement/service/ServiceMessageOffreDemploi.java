package eu.telecom_bretagne.cabinet_recrutement.service;

import java.util.Date;

import javax.ejb.EJB;
import javax.ejb.LocalBean;
import javax.ejb.Stateless;

import eu.telecom_bretagne.cabinet_recrutement.data.dao.CandidatureDAO;
import eu.telecom_bretagne.cabinet_recrutement.data.dao.MessageCandidatureDAO;
import eu.telecom_bretagne.cabinet_recrutement.data.dao.MessageOffreDEmploiDAO;
import eu.telecom_bretagne.cabinet_recrutement.data.dao.OffreEmploiDAO;

import eu.telecom_bretagne.cabinet_recrutement.data.model.MessageOffreDEmploi;


/**
 * Session Bean implementation class ServiceEntreprise
 * @author Philippe TANGUY
 */
@Stateless
@LocalBean
public class ServiceMessageOffreDemploi implements IServiceMessageOffreDEmploi
{
  //-----------------------------------------------------------------------------
  @EJB private MessageCandidatureDAO messageCandidatureDAO;
  @EJB private CandidatureDAO candidatureDAO;
  @EJB private OffreEmploiDAO offreEmploiDAO;
  @EJB private MessageOffreDEmploiDAO messageOffreDemploiDAO;
  
  //-----------------------------------------------------------------------------

  
  public MessageOffreDEmploi nouveauMessageOffreDEmploi(int idCandidature, int idOffreEmploi, String corpsMessage) {
	  MessageOffreDEmploi msgOffreDemploi = new MessageOffreDEmploi();
	  msgOffreDemploi.setCorpsmessage(corpsMessage);
	  msgOffreDemploi.setDateenvoi(new Date());
	  candidatureDAO.update(msgOffreDemploi.setCandidatureBean(candidatureDAO.findById(idCandidature)));
	  offreEmploiDAO.update(msgOffreDemploi.setOffreEmploiBean(offreEmploiDAO.findById(idOffreEmploi)));
	  return(messageOffreDemploiDAO.update(msgOffreDemploi));
  }
}
