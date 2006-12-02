/* Copyright (c) Microsoft Corporation. All rights reserved. */

// Lobby.aspx.cs
//
// Code-behind for Lobby.aspx.
//

using System;
using System.Collections.Generic;
using System.Collections.ObjectModel;
using System.Diagnostics;
using System.Globalization;
using System.IO;
using System.Security.Principal;
using System.Text;
using System.Text.RegularExpressions;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using Microsoft.LearningComponents;
using Microsoft.LearningComponents.Storage;
using Microsoft.LearningComponents.SharePoint;
using Microsoft.SharePoint;
using Microsoft.SharePointLearningKit;
using Microsoft.SharePointLearningKit.WebControls;
using Resources.Properties;
using Schema = Microsoft.SharePointLearningKit.Schema;
using Microsoft.LearningComponents.Frameset;
using Microsoft.SharePointLearningKit.Frameset;
using System.Threading;

namespace Microsoft.SharePointLearningKit.ApplicationPages
{

	/// <summary>
	/// Code-behind for Lobby.aspx.
	/// </summary>
	public class LobbyPage : SlkAppBasePage
	{
		#region Control Declarations
		[System.Diagnostics.CodeAnalysis.SuppressMessage("Microsoft.Naming", "CA1704:IdentifiersShouldBeSpelledCorrectly", MessageId = "lbl")]
		protected Label lblScoreValue;
		[System.Diagnostics.CodeAnalysis.SuppressMessage("Microsoft.Naming", "CA1704:IdentifiersShouldBeSpelledCorrectly", MessageId = "lbl")]
		protected Label lblStatusValue;
		[System.Diagnostics.CodeAnalysis.SuppressMessage("Microsoft.Naming", "CA1704:IdentifiersShouldBeSpelledCorrectly", MessageId = "lbl")]
		protected Label lblStartValue;
		[System.Diagnostics.CodeAnalysis.SuppressMessage("Microsoft.Naming", "CA1704:IdentifiersShouldBeSpelledCorrectly", MessageId = "lbl")]
		protected Label lblDueValue;
		[System.Diagnostics.CodeAnalysis.SuppressMessage("Microsoft.Naming", "CA1704:IdentifiersShouldBeSpelledCorrectly", MessageId = "lbl")]
		protected Label lblCommentsValue;
		[System.Diagnostics.CodeAnalysis.SuppressMessage("Microsoft.Naming", "CA1704:IdentifiersShouldBeSpelledCorrectly", MessageId = "lbl")]
		protected Label lblTitle;
		[System.Diagnostics.CodeAnalysis.SuppressMessage("Microsoft.Naming", "CA1704:IdentifiersShouldBeSpelledCorrectly", MessageId = "lbl")]
		protected Label lblDescription;
		[System.Diagnostics.CodeAnalysis.SuppressMessage("Microsoft.Naming", "CA1704:IdentifiersShouldBeSpelledCorrectly", MessageId = "lbl")]
		protected Label lblSite;
		[System.Diagnostics.CodeAnalysis.SuppressMessage("Microsoft.Naming", "CA1704:IdentifiersShouldBeSpelledCorrectly", MessageId = "lbl")]
		protected Label lblScore;
		[System.Diagnostics.CodeAnalysis.SuppressMessage("Microsoft.Naming", "CA1704:IdentifiersShouldBeSpelledCorrectly", MessageId = "lbl")]
		protected Label lblStatus;
		[System.Diagnostics.CodeAnalysis.SuppressMessage("Microsoft.Naming", "CA1704:IdentifiersShouldBeSpelledCorrectly", MessageId = "lbl")]
		protected Label lblStart;
		[System.Diagnostics.CodeAnalysis.SuppressMessage("Microsoft.Naming", "CA1704:IdentifiersShouldBeSpelledCorrectly", MessageId = "lbl")]
		protected Label lblDue;
		[System.Diagnostics.CodeAnalysis.SuppressMessage("Microsoft.Naming", "CA1704:IdentifiersShouldBeSpelledCorrectly", MessageId = "lbl")]
		protected Label lblComments;
		[System.Diagnostics.CodeAnalysis.SuppressMessage("Microsoft.Naming", "CA1704:IdentifiersShouldBeSpelledCorrectly", MessageId = "lbl")]
		protected Label lblAutoReturn;
		protected ErrorBanner errorBanner;
		[System.Diagnostics.CodeAnalysis.SuppressMessage("Microsoft.Naming", "CA1704:IdentifiersShouldBeSpelledCorrectly", MessageId = "tgr")]
		protected TableGridRow tgrComments;
		[System.Diagnostics.CodeAnalysis.SuppressMessage("Microsoft.Naming", "CA1704:IdentifiersShouldBeSpelledCorrectly", MessageId = "tgr")]
		protected TableGridRow tgrAutoReturn;
		[System.Diagnostics.CodeAnalysis.SuppressMessage("Microsoft.Naming", "CA1704:IdentifiersShouldBeSpelledCorrectly", MessageId = "tgr")]
		protected TableGridRow tgrSite;

		protected SlkButton slkButtonBegin;
		protected SlkButton slkButtonSubmit;
		protected SlkButton slkButtonDelete;
		[System.Diagnostics.CodeAnalysis.SuppressMessage("Microsoft.Naming", "CA1704:IdentifiersShouldBeSpelledCorrectly", MessageId = "lnk")]
		protected HyperLink lnkSite;
		[System.Diagnostics.CodeAnalysis.SuppressMessage("Microsoft.Naming", "CA1704:IdentifiersShouldBeSpelledCorrectly", MessageId = "lbl")]
		protected Label lblSiteValue;
		protected Image infoImage;

		protected Literal pageTitle;
		protected Literal pageTitleInTitlePage;
		protected Literal pageDescription;

		protected Panel contentPanel;
		#endregion

		#region Private Variables
		private LearnerAssignmentItemIdentifier m_learnerAssignmentId;
		private LearnerAssignmentProperties m_learnerAssignmentProperties;
		private bool setStatusToActive;
		#endregion

		#region Private Properties
		/// <summary>
		/// Gets the value of the "LearnerAssignmentId" query parameter.
		/// </summary>
		private LearnerAssignmentItemIdentifier LearnerAssignmentId
		{
			get
			{
				if (m_learnerAssignmentId == null)
				{
					long id;
					QueryString.Parse(QueryStringKeys.LearnerAssignmentId, out id, false);
					m_learnerAssignmentId = new LearnerAssignmentItemIdentifier(id);
				}
				return m_learnerAssignmentId;
			}
		}

		/// <summary>
		/// Gets the properties of the learner assignment being displayed by this page.
		/// </summary>
		private LearnerAssignmentProperties LearnerAssignmentProperties
		{
			get
			{
				if (m_learnerAssignmentProperties == null)
				{
					m_learnerAssignmentProperties = SlkStore.GetLearnerAssignmentProperties(LearnerAssignmentId,
						SlkRole.Learner);
				}
				return m_learnerAssignmentProperties;
			}
			set
			{
				m_learnerAssignmentProperties = value;
			}
		}
		#endregion

		#region OnPreRender
		/// <summary>
		///  Overrides OnPreRender.
		/// </summary>
		/// <param name="e">An EventArgs that contains the event data.</param>
        [System.Diagnostics.CodeAnalysis.SuppressMessage("Microsoft.Maintainability", "CA1502:AvoidExcessiveComplexity"), System.Diagnostics.CodeAnalysis.SuppressMessage("Microsoft.Design", "CA1031:DoNotCatchGeneralExceptionTypes")]
		protected override void OnPreRender(EventArgs e)
		{
			try
			{
				// setting default title
				pageTitle.Text = AppResources.LobbyBeginAssignmentText;
				pageTitleInTitlePage.Text = AppResources.LobbyBeginAssignmentText;

				SetResourceText();

				//// Set the status to active since this page will load before the Frameset can set the real status
				LearnerAssignmentState learnerAssignmentStatus = LearnerAssignmentProperties.Status;
				if (setStatusToActive && learnerAssignmentStatus == LearnerAssignmentState.NotStarted)
				{
					learnerAssignmentStatus = LearnerAssignmentState.Active;
				}

				ClientScript.RegisterClientScriptBlock(this.GetType(), "lblStatusValue", "var lblStatusValue = \"" + lblStatusValue.ClientID + "\";", true);
				if (learnerAssignmentStatus == LearnerAssignmentState.Completed
					&& LearnerAssignmentProperties.AutoReturn == true)
				{
					// assignment was probably changed to be "auto-return" after this learner submitted it; we'll
					// re-submit now to invoke the auto-return mechanism; note that we use
					// LearnerAssignmentState.Completed instead of LearnerAssignmentState.Final because
					// the latter would throw a security-related exception (learner's aren't allowed to move their
					// learner assignments into Final state) -- using Completed works because
					// SlkStore.ChangeLearnerAssignmentState performs auto-return even if the current state is
					// LearnerAssignmentState.Completed
					SlkStore.ChangeLearnerAssignmentState(LearnerAssignmentId, LearnerAssignmentState.Completed);
					// Set the property to null so that it will refresh the next time it is referenced
					LearnerAssignmentProperties = null;
				}

				lblTitle.Text = Server.HtmlEncode(LearnerAssignmentProperties.Title);
				lblDescription.Text = SlkUtilities.GetCrlfHtmlEncodedText(LearnerAssignmentProperties.Description);

				// for the assignment site, if the user doesn't have permission to view it
				// we'll catch the exception and hide the row
				bool previousValue = SPSecurity.CatchAccessDeniedException;
				SPSecurity.CatchAccessDeniedException = false;
				try
				{
					using(SPSite assignmentSite = new SPSite(LearnerAssignmentProperties.SPSiteGuid))
					{
					    using(SPWeb assignmentWeb = assignmentSite.OpenWeb(LearnerAssignmentProperties.SPWebGuid))
					    {

					        // If the assignment is in a different SPWeb redirect to it.
					        if (SPWeb.ID != assignmentWeb.ID)
						        Response.Redirect(SlkUtilities.UrlCombine(assignmentWeb.Url, Request.Path + "?" + Request.QueryString.ToString()));

					        lnkSite.Text = Server.HtmlEncode(assignmentWeb.Title);
					        lnkSite.NavigateUrl = assignmentWeb.ServerRelativeUrl;
                        }
                    }
				}
				catch (UnauthorizedAccessException)
				{
					lblSiteValue.Text = AppResources.LobbyInvalidSite;
					lblSiteValue.Visible = true;
				}
				catch (FileNotFoundException)
				{
					lblSiteValue.Text = AppResources.LobbyInvalidSite;
					lblSiteValue.Visible = true;
				}
				finally
				{
					SPSecurity.CatchAccessDeniedException = previousValue;
				}

				if (LearnerAssignmentProperties.SuccessStatus == SuccessStatus.Passed
					&& LearnerAssignmentProperties.FinalPoints.HasValue
					&& LearnerAssignmentProperties.FinalPoints.Value == 0.0
					)
				{
					lblScoreValue.Text = string.Empty;
				}
				else
				{

					if (learnerAssignmentStatus != LearnerAssignmentState.Final)
					{
						if (LearnerAssignmentProperties.PointsPossible.HasValue)
							lblScoreValue.Text = string.Format(CultureInfo.CurrentCulture, AppResources.LobbyPointsNoValuePointsPossible, LearnerAssignmentProperties.PointsPossible);
						else
							lblScoreValue.Text = string.Format(CultureInfo.CurrentCulture, AppResources.LobbyPointsNoValue, LearnerAssignmentProperties.FinalPoints);
					}
					else
					{
						string finalPoints = AppResources.LobbyPointsNoValue;
						if (LearnerAssignmentProperties.FinalPoints.HasValue)
							finalPoints = LearnerAssignmentProperties.FinalPoints.Value.ToString(CultureInfo.CurrentCulture);

						if (LearnerAssignmentProperties.PointsPossible.HasValue)
							lblScoreValue.Text = string.Format(CultureInfo.CurrentCulture, AppResources.LobbyPointsValuePointsPossible, finalPoints, LearnerAssignmentProperties.PointsPossible);
						else
							lblScoreValue.Text = string.Format(CultureInfo.CurrentCulture, AppResources.LobbyPointsValue, finalPoints);
					}
				}

				lblStartValue.Text = string.Format(CultureInfo.CurrentCulture, AppResources.LongDateShortTime, LearnerAssignmentProperties.StartDate);
				if (LearnerAssignmentProperties.DueDate.HasValue)
					lblDueValue.Text = string.Format(CultureInfo.CurrentCulture, AppResources.LongDateShortTime, LearnerAssignmentProperties.DueDate.Value);

				if (LearnerAssignmentProperties.InstructorComments.Length != 0)
					lblCommentsValue.Text = SlkUtilities.GetCrlfHtmlEncodedText(LearnerAssignmentProperties.InstructorComments);
				else
					tgrComments.Visible = false;

				lblStatusValue.Text = Server.HtmlEncode(SlkUtilities.GetLearnerAssignmentState(learnerAssignmentStatus));
				AssignmentView view = AssignmentView.Execute;
				switch (learnerAssignmentStatus)
				{
					case LearnerAssignmentState.NotStarted:
						slkButtonBegin.Text = AppResources.LobbyBeginAssignmentText;
						slkButtonBegin.ToolTip = AppResources.LobbyBeginAssignmentToolTip;
						pageTitle.Text = AppResources.LobbyBeginAssignmentText;
						pageTitleInTitlePage.Text = AppResources.LobbyBeginAssignmentText;
						break;
					case LearnerAssignmentState.Active:
						slkButtonBegin.Text = AppResources.LobbyResumeAssignmentText;
						slkButtonBegin.ToolTip = AppResources.LobbyResumeAssignmentToolTip;
						pageTitle.Text = AppResources.LobbyResumeAssignmentText;
						pageTitleInTitlePage.Text = AppResources.LobbyResumeAssignmentText;
						break;
					case LearnerAssignmentState.Completed:
						slkButtonBegin.Text = AppResources.LobbyReviewAssignmentText;
						slkButtonBegin.ToolTip = AppResources.LobbyReviewAssignmentToolTipCompleted;
						slkButtonBegin.Enabled = false;
						pageTitle.Text = AppResources.LobbyReviewAssignmentText;
						pageTitleInTitlePage.Text = AppResources.LobbyReviewAssignmentText;
						slkButtonSubmit.Visible = false;
						break;
					case LearnerAssignmentState.Final:
						slkButtonBegin.Text = AppResources.LobbyReviewAssignmentText;
						slkButtonBegin.ToolTip = AppResources.LobbyReviewAssignmentToolTip;
						pageTitle.Text = AppResources.LobbyReviewAssignmentText;
						pageTitleInTitlePage.Text = AppResources.LobbyReviewAssignmentText;
						slkButtonSubmit.Visible = false;
						view = AssignmentView.StudentReview;
						break;
					default:
						break;
				}

				if (!(LearnerAssignmentProperties.RootActivityId == null
					&& learnerAssignmentStatus == LearnerAssignmentState.NotStarted))
				{
					slkButtonBegin.OnClientClick = String.Format(CultureInfo.InvariantCulture, "SlkOpenFramesetWindow('Frameset/Frameset.aspx?{0}={1}&{2}={3}'); return false;",
						FramesetQueryParameter.SlkView, view, FramesetQueryParameter.LearnerAssignmentId, LearnerAssignmentId.GetKey());
					slkButtonBegin.NavigateUrl = String.Format(CultureInfo.InvariantCulture, "javascript:SlkOpenFramesetWindow('Frameset/Frameset.aspx?{0}={1}&{2}={3}');",
						FramesetQueryParameter.SlkView, view, FramesetQueryParameter.LearnerAssignmentId, LearnerAssignmentId.GetKey());
				}
				slkButtonBegin.ImageUrl = Constants.ImagePath + Constants.NewDocumentIcon;

				if (LearnerAssignmentProperties.CreatedById.Equals(LearnerAssignmentProperties.LearnerId)
					&& !LearnerAssignmentProperties.HasInstructors)
				{
					slkButtonDelete.Text = AppResources.LobbyDeleteAssignmentText;
					slkButtonDelete.ToolTip = AppResources.LobbyDeleteToolTip;
					slkButtonDelete.OnClientClick = String.Format(CultureInfo.CurrentCulture, "javascript: return confirm('{0}');",
						AppResources.LobbyDeleteMessage);
					slkButtonDelete.ImageUrl = Constants.ImagePath + Constants.DeleteIcon;
				}
				else
				{
					slkButtonDelete.Visible = false;
				}

				if (LearnerAssignmentProperties.HasInstructors)
				{
					slkButtonSubmit.Text = AppResources.LobbySubmitText;
					slkButtonSubmit.ToolTip = AppResources.LobbySubmitToolTip;
					slkButtonSubmit.OnClientClick = String.Format(CultureInfo.CurrentCulture, "javascript: return confirm('{0}');",
						AppResources.LobbySubmitMessage);
					slkButtonSubmit.ImageUrl = Constants.ImagePath + Constants.SubmitIcon;
				}
				else
				{
					slkButtonSubmit.Text = AppResources.LobbyMarkasCompleteText;
					slkButtonSubmit.ToolTip = AppResources.LobbyMarkasCompleteToolTip;
					slkButtonSubmit.OnClientClick = String.Format(CultureInfo.CurrentCulture, "javascript: return confirm('{0}');",
						 AppResources.LobbyMarkasCompleteMessage);
					slkButtonSubmit.ImageUrl = Constants.ImagePath + Constants.MarkCompleteIcon;
				}

				slkButtonBegin.AccessKey = AppResources.LobbyBeginAccessKey;
				slkButtonDelete.AccessKey = AppResources.LobbyDeleteAccessKey;
				slkButtonSubmit.AccessKey = AppResources.LobbySubmitAccessKey;

				tgrAutoReturn.Visible = LearnerAssignmentProperties.AutoReturn;

				contentPanel.Visible = true;
			}
			catch (InvalidOperationException)
			{
				errorBanner.AddException(new SafeToDisplayException(AppResources.LobbyInvalidLearnerAssignmentId, LearnerAssignmentId.GetKey()));
				contentPanel.Visible = false;
			}
			catch (ThreadAbortException)
			{
				// Calling Response.Redirect throws a ThreadAbortException which needs to be rethrown
				throw;
			}
			catch (Exception ex)
			{
				errorBanner.AddException(ex);
				contentPanel.Visible = false;
			}
		}

		/// <summary>
		/// Overrides OnLoad.
		/// </summary>
		/// <param name="e"></param>
		[System.Diagnostics.CodeAnalysis.SuppressMessage("Microsoft.Design", "CA1031:DoNotCatchGeneralExceptionTypes")]
		protected override void OnLoad(EventArgs e)
		{
			// Using OnLoad to wire up the click event if needed.
			try
			{
				// Check if non-e-learning content
				if (LearnerAssignmentProperties.RootActivityId == null
					&& LearnerAssignmentProperties.Status == LearnerAssignmentState.NotStarted)
				{
					slkButtonBegin.Click += new EventHandler(slkButtonBegin_Click);
				}
			}
			catch
			{
				// Any Exceptions here will also be caught in PreRender
			}

			base.OnLoad(e);
		}

		void slkButtonBegin_Click(object sender, EventArgs e)
		{
			// Only for non-e-learning content
			ClientScript.RegisterStartupScript(this.GetType(), "SlkOpenFrameset",
				String.Format(CultureInfo.InvariantCulture, "SlkOpenFramesetWindow('Frameset/Frameset.aspx?{0}={1}&{2}={3}');",
				FramesetQueryParameter.SlkView, AssignmentView.Execute, FramesetQueryParameter.LearnerAssignmentId, LearnerAssignmentId.GetKey()), true);

			setStatusToActive = true;
		}
		#endregion

		/// <summary>
		/// slkButtonSubmit Click event handler
		/// </summary>
		/// <param name="sender"></param>
		/// <param name="e"></param>
		[System.Diagnostics.CodeAnalysis.SuppressMessage("Microsoft.Naming", "CA1709:IdentifiersShouldBeCasedCorrectly", MessageId = "Member"), System.Diagnostics.CodeAnalysis.SuppressMessage("Microsoft.Design", "CA1031:DoNotCatchGeneralExceptionTypes")]
		protected void slkButtonSubmit_Click(object sender, EventArgs e)
		{
			try
			{
                try
                {
                    SlkStore.ChangeLearnerAssignmentState(LearnerAssignmentId, LearnerAssignmentState.Completed);
                }
                catch (InvalidOperationException)
				{
                    // state transition isn't supported
					errorBanner.AddException(new SafeToDisplayException(AppResources.LobbyCannotChangeState));
				}
				// Clear the object so it will refresh from the database
				LearnerAssignmentProperties = null;
			}
			catch (Exception)
			{
				// any exceptions here will be handled in PreRender
			}
		}

		/// <summary>
		/// slkButtonDelete Click event handler
		/// </summary>
		/// <param name="sender"></param>
		/// <param name="e"></param>
		[System.Diagnostics.CodeAnalysis.SuppressMessage("Microsoft.Naming", "CA1709:IdentifiersShouldBeCasedCorrectly", MessageId = "Member"), System.Diagnostics.CodeAnalysis.SuppressMessage("Microsoft.Design", "CA1031:DoNotCatchGeneralExceptionTypes")]
		protected void slkButtonDelete_Click(object sender, EventArgs e)
		{
			try
			{
				SlkStore.DeleteAssignment(LearnerAssignmentProperties.AssignmentId);
				Response.Redirect(SPWeb.ServerRelativeUrl, true);
			}
			catch (ThreadAbortException)
			{
				// Calling Response.Redirect throws a ThreadAbortException which will
				// flag an error in the next step if we don't do this.
				throw;
			}
			catch (Exception)
			{
				// any exceptions here will be handled in PreRender
			}
		}

		private void SetResourceText()
		{
			pageDescription.Text = AppResources.LobbyPageDescription;

			lblSite.Text = AppResources.LobbylblSite;
			lblScore.Text = AppResources.LobbylblScore;
			lblStatus.Text = AppResources.LobbylblStatus;
			lblStart.Text = AppResources.LobbylblStart;
			lblDue.Text = AppResources.LobbylblDue;
			lblComments.Text = AppResources.LobbylblComments;
			lblAutoReturn.Text = AppResources.LobbylblAutoReturn;
			infoImage.AlternateText = AppResources.SlkErrorTypeInfoToolTip;
			ClientScript.RegisterClientScriptBlock(this.GetType(), "SlkWindowAlreadyOpen",
				string.Format(CultureInfo.CurrentCulture, "var SlkWindowAlreadyOpen = \"{0}\";", AppResources.LobbyWindowAlreadyOpen), true);
		}
	}
}