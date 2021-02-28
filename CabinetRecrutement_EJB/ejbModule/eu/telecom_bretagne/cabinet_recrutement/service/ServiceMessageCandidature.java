package eu.telecom_bretagne.cabinet_recrutement.service;

import java.util.Date;

import javax.ejb.EJB;
import javax.ejb.LocalBean;
import javax.ejb.Stateless;

import eu.telecom_bretagne.cabinet_recrutement.data.dao.CandidatureDAO;
import eu.telecom_bretagne.cabinet_recrutement.data.dao.MessageCandidatureDAO;
import eu.telecom_bretagne.cabinet_recrutement.data.dao.OffreEmploiDAO;

import eu.telecom_bretagne.cabinet_recrutement.data.model.MessageCandidature;


/**
 * Session Bean implementation class ServiceEntreprise
 * @author Philippe TANGUY
 */
@Stateless
@LocalBean
public class ServiceMessageCandidature implements IServiceMessageCandidature
{
  //-----------------------------------------------------------------------------
  @EJB private MessageCandidatureDAO messageCandidatureDAO;
  @EJB private CandidatureDAO candidatureDAO;
  @EJB private OffreEmploiDAO offreEmploiDAO;
  
  //-----------------------------------------------------------------------------

  
  public MessageCandidature nouveauMessageCandidature(int idCandidature, int idOffreEmploi, String corpsMessage) {
	  MessageCandidature msgCandidature = new MessageCandidature();
	  msgCandidature.setCorpsmessage(corpsMessage);
	  msgCandidature.setDateenvoi(new Date());
	  candidatureDAO.update(msgCandidature.setCandidatureBean(candidatureDAO.findById(idCandidature)));
	  offreEmploiDAO.update(msgCandidature.setOffreEmploiBean(offreEmploiDAO.findById(idOffreEmploi)));
	  return(messageCandidatureDAO.update(msgCandidature));
  }
}
