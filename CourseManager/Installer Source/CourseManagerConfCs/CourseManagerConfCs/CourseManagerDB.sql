USE [SLK4]
GO
/****** Object:  Table [dbo].[Courses]    Script Date: 03/13/2008 22:23:53 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[Courses](
	[GUID_crs] [varchar](50) NOT NULL,
	[Name_crs] [varchar](50) NOT NULL,
 CONSTRAINT [PK_clsCourse] PRIMARY KEY CLUSTERED 
(
	[GUID_crs] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[UserRoles]    Script Date: 03/13/2008 22:23:53 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[UserRoles](
	[GUID_uro] [varchar](50) NOT NULL,
	[Name_uro] [varchar](50) NULL,
 CONSTRAINT [PK_clsUserRole] PRIMARY KEY CLUSTERED 
(
	[GUID_uro] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[ActivityGroupStatuses]    Script Date: 03/13/2008 22:23:53 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[ActivityGroupStatuses](
	[GUID_ags] [varchar](50) NOT NULL,
	[Name_ags] [varchar](50) NOT NULL,
	[Description_ags] [varchar](100) NOT NULL,
	[Icon_ags] [binary](1024) NULL,
 CONSTRAINT [PK_ActivityGroupStatuses] PRIMARY KEY CLUSTERED 
(
	[GUID_ags] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[AssignedActivityStatuses]    Script Date: 03/13/2008 22:23:53 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[AssignedActivityStatuses](
	[GUID_aas] [varchar](50) NOT NULL,
	[Name_aas] [varchar](50) NOT NULL,
	[Description_aas] [varchar](100) NOT NULL,
	[StatusIcon_aas] [binary](1024) NULL,
 CONSTRAINT [PK_AssignedActivityStatuses] PRIMARY KEY CLUSTERED 
(
	[GUID_aas] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[SPUser]    Script Date: 03/13/2008 22:23:53 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[SPUser](
	[Email_SPU] [varchar](50) NULL,
	[ID_SPU] [varchar](50) NOT NULL,
	[IsDomainGroup_SPU] [bit] NULL,
	[IsSiteAdmin_SPU] [bit] NULL,
	[LoginName_SPU] [varchar](50) NULL,
	[Name_SPU] [varchar](50) NULL,
	[OwnedGroups_SPU] [varchar](50) NULL,
	[Roles_SPU] [varchar](50) NULL,
 CONSTRAINT [PK_SPUser] PRIMARY KEY CLUSTERED 
(
	[ID_SPU] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[Courses_Users]    Script Date: 03/13/2008 22:23:53 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[Courses_Users](
	[GUID_cur] [varchar](50) NOT NULL,
	[CourseGUID_cur] [varchar](50) NOT NULL,
	[UserGUID_cur] [varchar](50) NOT NULL,
 CONSTRAINT [PK_Course_User] PRIMARY KEY CLUSTERED 
(
	[GUID_cur] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
SET ANSI_PADDING OFF
GO
/****** Object:  StoredProcedure [dbo].[SP_GetActivityStatusIconData]    Script Date: 03/13/2008 22:23:53 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[SP_GetActivityStatusIconData] 
	-- Add the parameters for the stored procedure here
	@ActivityStatusGUID varchar(50)
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here
	SELECT StatusIcon_ast FROM ActivityStatuses WHERE GUID_ast = @ActivityStatusGUID
END
GO
/****** Object:  Table [dbo].[ActivityStatuses]    Script Date: 03/13/2008 22:23:53 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[ActivityStatuses](
	[GUID_ast] [varchar](50) NOT NULL,
	[Name_ast] [varchar](50) NOT NULL,
	[Description_ast] [varchar](100) NOT NULL,
	[StatusIcon_ast] [varbinary](max) NULL,
 CONSTRAINT [PK_CLSActivityStatus] PRIMARY KEY CLUSTERED 
(
	[GUID_ast] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[UILayouts]    Script Date: 03/13/2008 22:23:53 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[UILayouts](
	[GUID_ply] [varchar](50) NOT NULL,
	[Name_ply] [varchar](50) NOT NULL,
	[ObjectType_ply] [varchar](255) NOT NULL,
	[LayoutXML_ply] [text] NOT NULL,
 CONSTRAINT [PK_UILayouts] PRIMARY KEY CLUSTERED 
(
	[GUID_ply] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[ConfigurationProfiles]    Script Date: 03/13/2008 22:23:53 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[ConfigurationProfiles](
	[GUID_cfp] [varchar](50) NOT NULL,
	[Name_cfp] [varchar](25) NOT NULL,
 CONSTRAINT [PK_ConfigurationProfiles] PRIMARY KEY CLUSTERED 
(
	[GUID_cfp] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[ConfigurationProperties]    Script Date: 03/13/2008 22:23:53 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[ConfigurationProperties](
	[GUID_cpr] [varchar](50) NOT NULL,
	[Name_cpr] [nvarchar](250) NOT NULL,
	[DefaultValue_cpr] [nvarchar](max) NOT NULL,
	[Encryption_cpr] [bit] NOT NULL,
 CONSTRAINT [PK_ConfigurationProperties] PRIMARY KEY CLUSTERED 
(
	[GUID_cpr] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[Users]    Script Date: 03/13/2008 22:23:53 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[Users](
	[GUID_usr] [varchar](50) NOT NULL,
	[Name_usr] [varchar](50) NOT NULL,
	[LoginName_usr] [varchar](50) NOT NULL,
	[Email_usr] [varchar](50) NOT NULL,
	[UserRoleGUID_usr] [varchar](50) NOT NULL,
 CONSTRAINT [PK_clsUser] PRIMARY KEY CLUSTERED 
(
	[GUID_usr] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[ActivityGroups]    Script Date: 03/13/2008 22:23:53 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[ActivityGroups](
	[GUID_agr] [varchar](50) NOT NULL,
	[Name_agr] [varchar](50) NOT NULL,
	[Outcome_agr] [varchar](255) NOT NULL,
	[WeekFrom_agr] [int] NOT NULL,
	[WeekTo_agr] [int] NOT NULL,
	[CourseGUID_agr] [varchar](50) NOT NULL,
	[ActivityGroupStatusGUID_agr] [varchar](50) NOT NULL,
	[Priority_agr] [int] NOT NULL,
 CONSTRAINT [PK_clsActivityGroup] PRIMARY KEY CLUSTERED 
(
	[GUID_agr] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[Courses_Users_Activities]    Script Date: 03/13/2008 22:23:53 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[Courses_Users_Activities](
	[GUID_cua] [varchar](50) NOT NULL,
	[FinalScore_cua] [float] NOT NULL,
	[MasterGUID_cua] [varchar](50) NOT NULL,
	[AssignedActivityStatusGUID_cua] [varchar](50) NOT NULL,
	[DetailGUID_cua] [varchar](50) NOT NULL,
 CONSTRAINT [PK_clsAssignedActivity] PRIMARY KEY CLUSTERED 
(
	[GUID_cua] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[SLKUser]    Script Date: 03/13/2008 22:23:53 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[SLKUser](
	[SlkUserId_SU] [varchar](50) NOT NULL,
	[Name_SU] [varchar](50) NULL,
	[SPUser_SU] [varchar](50) NULL,
	[UserId_SU] [varchar](50) NULL,
 CONSTRAINT [PK_slkUser] PRIMARY KEY CLUSTERED 
(
	[SlkUserId_SU] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[Activities]    Script Date: 03/13/2008 22:23:53 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[Activities](
	[GUID_act] [varchar](50) NOT NULL,
	[SLKGUID_act] [varchar](50) NULL,
	[Name_act] [varchar](50) NOT NULL,
	[AssignDate_act] [datetime] NOT NULL,
	[DueDate_act] [datetime] NOT NULL,
	[MaxScore_act] [int] NOT NULL,
	[Gradeable_act] [bit] NOT NULL,
	[Weight_act] [int] NOT NULL,
	[ActivityGroupGUID_act] [varchar](50) NOT NULL,
	[ActivityStatusGUID_act] [varchar](50) NOT NULL,
	[Description_act] [varchar](255) NOT NULL,
	[FileURL_act] [varchar](255) NOT NULL,
 CONSTRAINT [PK_clsActivity] PRIMARY KEY CLUSTERED 
(
	[GUID_act] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[SLKLearnerAssignmentProperties]    Script Date: 03/13/2008 22:23:53 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[SLKLearnerAssignmentProperties](
	[LearnerAssignmentId_SLAP] [varchar](50) NOT NULL,
	[AssignmentId_SLAP] [varchar](50) NULL,
	[CreatedById_SLAP] [varchar](50) NULL,
	[CreatedByName_SLAP] [varchar](50) NULL,
	[Description_SLAP] [varchar](255) NULL,
	[DueDate_SLAP] [varchar](50) NULL,
	[FinalPoints_SLAP] [varchar](50) NULL,
	[GradedPoints_SLAP] [varchar](50) NULL,
	[InstructorComments_SLAP] [varchar](50) NULL,
	[LearnerID_SLAP] [varchar](50) NULL,
	[LearnerName_SLAP] [varchar](50) NULL,
	[Location_SLAP] [varchar](50) NULL,
	[PointsPossible_SLAP] [varchar](50) NULL,
	[StatusInformation_SLAP] [varchar](50) NULL,
	[Title_SLAP] [varchar](50) NULL,
	[SPSiteGuid_SLAP] [varchar](50) NULL,
	[SPWebGuid_SLAP] [varchar](50) NULL,
	[StartDate_SLAP] [varchar](50) NULL,
	[Status_SLAP] [varchar](50) NULL,
 CONSTRAINT [PK_slkLearnerAssignmentProperties] PRIMARY KEY CLUSTERED 
(
	[LearnerAssignmentId_SLAP] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[SLKGradingProperties]    Script Date: 03/13/2008 22:23:53 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[SLKGradingProperties](
	[FinalPoints_SGP] [varchar](50) NULL,
	[GradedPoints_SGP] [varchar](50) NULL,
	[InstructorComments_SGP] [varchar](50) NULL,
	[LearnerName_SGP] [varchar](50) NULL,
	[LearnerAssignmentId_SGP] [varchar](50) NULL
) ON [PRIMARY]
GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[SLKAssignmentProperties]    Script Date: 03/13/2008 22:23:53 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[SLKAssignmentProperties](
	[AssignmentId_SAP] [varchar](50) NOT NULL,
	[AutoReturn_SAP] [bit] NULL,
	[CreatedById_SAP] [varchar](50) NULL,
	[DateCreated_SAP] [datetime] NULL,
	[Description_SAP] [varchar](255) NULL,
	[DueDate_SAP] [datetime] NULL,
	[Instructors_SAP] [varchar](50) NULL,
	[Learners_SAP] [varchar](50) NULL,
	[Location_SAP] [varchar](50) NULL,
	[PointsPossible_SAP] [smallint] NULL,
	[SPSiteGuid_SAP] [varchar](50) NULL,
	[SPWebGuid_SAP] [varchar](50) NULL,
	[StartDate_SAP] [datetime] NULL,
	[Title_SAP] [varchar](50) NULL,
 CONSTRAINT [PK_slkAssignmentProperties] PRIMARY KEY CLUSTERED 
(
	[AssignmentId_SAP] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[Profiles_Properties]    Script Date: 03/13/2008 22:23:53 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[Profiles_Properties](
	[GUID_ppr] [varchar](50) NOT NULL,
	[MasterGUID_ppr] [varchar](50) NOT NULL,
	[DetailGUID_ppr] [varchar](50) NOT NULL,
	[Value_ppr] [varchar](max) NOT NULL,
	[Encryption_ppr] [bit] NOT NULL,
 CONSTRAINT [PK_Profiles_Properties] PRIMARY KEY CLUSTERED 
(
	[GUID_ppr] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
SET ANSI_PADDING OFF
GO
/****** Object:  StoredProcedure [dbo].[SP_ReIndexActivityGroupPriority]    Script Date: 03/13/2008 22:23:53 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[SP_ReIndexActivityGroupPriority]
	@p_CourseGUID varchar(50)
AS

declare @i int, @rowCount int;

declare @ActivityGroupStore as Table( ID_ags int identity(1,1),
									  GUID_ags varchar(50),
									  Priority_ags int);


insert into @ActivityGroupStore (GUID_ags,Priority_ags)
select GUID_agr,Priority_agr
from ActivityGroups
where CourseGUID_agr = @p_CourseGUID
order by Priority_agr;

set @rowCount = @@ROWCOUNT;
set @i = 1;

while (@i <= @rowCount)
begin
	update ActivityGroups
	set Priority_agr = @i				
	where GUID_agr = (select GUID_ags 
					  from @ActivityGroupStore
					  where ID_ags = @i); 
	set @i = @i+1;
end
GO
/****** Object:  ForeignKey [FK_Activities_ActivityGroups]    Script Date: 03/13/2008 22:23:53 ******/
ALTER TABLE [dbo].[Activities]  WITH CHECK ADD  CONSTRAINT [FK_Activities_ActivityGroups] FOREIGN KEY([ActivityGroupGUID_act])
REFERENCES [dbo].[ActivityGroups] ([GUID_agr])
GO
ALTER TABLE [dbo].[Activities] CHECK CONSTRAINT [FK_Activities_ActivityGroups]
GO
/****** Object:  ForeignKey [FK_Activities_ActivityStatuses]    Script Date: 03/13/2008 22:23:53 ******/
ALTER TABLE [dbo].[Activities]  WITH CHECK ADD  CONSTRAINT [FK_Activities_ActivityStatuses] FOREIGN KEY([ActivityStatusGUID_act])
REFERENCES [dbo].[ActivityStatuses] ([GUID_ast])
GO
ALTER TABLE [dbo].[Activities] CHECK CONSTRAINT [FK_Activities_ActivityStatuses]
GO
/****** Object:  ForeignKey [FK_ActivityGroups_ActivityGroupStatuses]    Script Date: 03/13/2008 22:23:53 ******/
ALTER TABLE [dbo].[ActivityGroups]  WITH CHECK ADD  CONSTRAINT [FK_ActivityGroups_ActivityGroupStatuses] FOREIGN KEY([ActivityGroupStatusGUID_agr])
REFERENCES [dbo].[ActivityGroupStatuses] ([GUID_ags])
GO
ALTER TABLE [dbo].[ActivityGroups] CHECK CONSTRAINT [FK_ActivityGroups_ActivityGroupStatuses]
GO
/****** Object:  ForeignKey [FK_AssignedActivities_Activities]    Script Date: 03/13/2008 22:23:53 ******/
ALTER TABLE [dbo].[Courses_Users_Activities]  WITH CHECK ADD  CONSTRAINT [FK_AssignedActivities_Activities] FOREIGN KEY([DetailGUID_cua])
REFERENCES [dbo].[Activities] ([GUID_act])
GO
ALTER TABLE [dbo].[Courses_Users_Activities] CHECK CONSTRAINT [FK_AssignedActivities_Activities]
GO
/****** Object:  ForeignKey [FK_AssignedActivities_AssignedActivityStatuses]    Script Date: 03/13/2008 22:23:53 ******/
ALTER TABLE [dbo].[Courses_Users_Activities]  WITH CHECK ADD  CONSTRAINT [FK_AssignedActivities_AssignedActivityStatuses] FOREIGN KEY([AssignedActivityStatusGUID_cua])
REFERENCES [dbo].[AssignedActivityStatuses] ([GUID_aas])
GO
ALTER TABLE [dbo].[Courses_Users_Activities] CHECK CONSTRAINT [FK_AssignedActivities_AssignedActivityStatuses]
GO
/****** Object:  ForeignKey [FK_AssignedActivities_Courses_Users]    Script Date: 03/13/2008 22:23:53 ******/
ALTER TABLE [dbo].[Courses_Users_Activities]  WITH CHECK ADD  CONSTRAINT [FK_AssignedActivities_Courses_Users] FOREIGN KEY([MasterGUID_cua])
REFERENCES [dbo].[Courses_Users] ([GUID_cur])
GO
ALTER TABLE [dbo].[Courses_Users_Activities] CHECK CONSTRAINT [FK_AssignedActivities_Courses_Users]
GO
/****** Object:  ForeignKey [FK_Profiles_Properties_ConfigurationProfiles]    Script Date: 03/13/2008 22:23:53 ******/
ALTER TABLE [dbo].[Profiles_Properties]  WITH CHECK ADD  CONSTRAINT [FK_Profiles_Properties_ConfigurationProfiles] FOREIGN KEY([MasterGUID_ppr])
REFERENCES [dbo].[ConfigurationProfiles] ([GUID_cfp])
GO
ALTER TABLE [dbo].[Profiles_Properties] CHECK CONSTRAINT [FK_Profiles_Properties_ConfigurationProfiles]
GO
/****** Object:  ForeignKey [FK_Profiles_Properties_ConfigurationProperties]    Script Date: 03/13/2008 22:23:53 ******/
ALTER TABLE [dbo].[Profiles_Properties]  WITH CHECK ADD  CONSTRAINT [FK_Profiles_Properties_ConfigurationProperties] FOREIGN KEY([DetailGUID_ppr])
REFERENCES [dbo].[ConfigurationProperties] ([GUID_cpr])
GO
ALTER TABLE [dbo].[Profiles_Properties] CHECK CONSTRAINT [FK_Profiles_Properties_ConfigurationProperties]
GO
/****** Object:  ForeignKey [FK_SLKAssignmentProperties_SlkUser]    Script Date: 03/13/2008 22:23:53 ******/
ALTER TABLE [dbo].[SLKAssignmentProperties]  WITH CHECK ADD  CONSTRAINT [FK_SLKAssignmentProperties_SlkUser] FOREIGN KEY([CreatedById_SAP])
REFERENCES [dbo].[SLKUser] ([SlkUserId_SU])
GO
ALTER TABLE [dbo].[SLKAssignmentProperties] CHECK CONSTRAINT [FK_SLKAssignmentProperties_SlkUser]
GO
/****** Object:  ForeignKey [FK_slkGradingProperties_slkLearnerAssignmentProperties]    Script Date: 03/13/2008 22:23:53 ******/
ALTER TABLE [dbo].[SLKGradingProperties]  WITH CHECK ADD  CONSTRAINT [FK_slkGradingProperties_slkLearnerAssignmentProperties] FOREIGN KEY([LearnerAssignmentId_SGP])
REFERENCES [dbo].[SLKLearnerAssignmentProperties] ([LearnerAssignmentId_SLAP])
GO
ALTER TABLE [dbo].[SLKGradingProperties] CHECK CONSTRAINT [FK_slkGradingProperties_slkLearnerAssignmentProperties]
GO
/****** Object:  ForeignKey [FK_SLKLearnerAssignmentProperties_CLSActivityStatus]    Script Date: 03/13/2008 22:23:53 ******/
ALTER TABLE [dbo].[SLKLearnerAssignmentProperties]  WITH CHECK ADD  CONSTRAINT [FK_SLKLearnerAssignmentProperties_CLSActivityStatus] FOREIGN KEY([Status_SLAP])
REFERENCES [dbo].[ActivityStatuses] ([GUID_ast])
GO
ALTER TABLE [dbo].[SLKLearnerAssignmentProperties] CHECK CONSTRAINT [FK_SLKLearnerAssignmentProperties_CLSActivityStatus]
GO
/****** Object:  ForeignKey [FK_slkLearnerAssignmentProperties_slkAssignmentProperties]    Script Date: 03/13/2008 22:23:53 ******/
ALTER TABLE [dbo].[SLKLearnerAssignmentProperties]  WITH CHECK ADD  CONSTRAINT [FK_slkLearnerAssignmentProperties_slkAssignmentProperties] FOREIGN KEY([AssignmentId_SLAP])
REFERENCES [dbo].[SLKAssignmentProperties] ([AssignmentId_SAP])
GO
ALTER TABLE [dbo].[SLKLearnerAssignmentProperties] CHECK CONSTRAINT [FK_slkLearnerAssignmentProperties_slkAssignmentProperties]
GO
/****** Object:  ForeignKey [FK_SLKUser_clsUser]    Script Date: 03/13/2008 22:23:53 ******/
ALTER TABLE [dbo].[SLKUser]  WITH CHECK ADD  CONSTRAINT [FK_SLKUser_clsUser] FOREIGN KEY([UserId_SU])
REFERENCES [dbo].[Users] ([GUID_usr])
GO
ALTER TABLE [dbo].[SLKUser] CHECK CONSTRAINT [FK_SLKUser_clsUser]
GO
/****** Object:  ForeignKey [FK_slkUser_SPUser]    Script Date: 03/13/2008 22:23:53 ******/
ALTER TABLE [dbo].[SLKUser]  WITH CHECK ADD  CONSTRAINT [FK_slkUser_SPUser] FOREIGN KEY([SPUser_SU])
REFERENCES [dbo].[SPUser] ([ID_SPU])
GO
ALTER TABLE [dbo].[SLKUser] CHECK CONSTRAINT [FK_slkUser_SPUser]
GO
/****** Object:  ForeignKey [FK_Users_UserRoles]    Script Date: 03/13/2008 22:23:53 ******/
ALTER TABLE [dbo].[Users]  WITH CHECK ADD  CONSTRAINT [FK_Users_UserRoles] FOREIGN KEY([UserRoleGUID_usr])
REFERENCES [dbo].[UserRoles] ([GUID_uro])
GO
ALTER TABLE [dbo].[Users] CHECK CONSTRAINT [FK_Users_UserRoles]
GO
