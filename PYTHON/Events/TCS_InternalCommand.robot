*** Settings ***
Documentation    TCS_InternalCommand communications tests.
Force Tags    python    TSS-2724
Suite Setup    Run Keywords    Log Many    ${Host}    ${subSystem}    ${component}    ${timeout}
...    AND    Create Session    Sender    AND    Create Session    Logger
Suite Teardown    Close All Connections
Library    SSHLibrary
Library    String
Resource    ../../Global_Vars.robot
Resource    ../../common.robot

*** Variables ***
${subSystem}    tcs
${component}    InternalCommand
${timeout}    30s

*** Test Cases ***
Verify Component Sender and Logger
    [Tags]    smoke
    File Should Exist    ${SALWorkDir}/${subSystem}/python/${subSystem}_Event_${component}.py
    File Should Exist    ${SALWorkDir}/${subSystem}/python/${subSystem}_EventLogger_${component}.py

Start Sender - Verify Missing Inputs Error
    [Tags]    functional
    Switch Connection    Sender
    Comment    Move to working directory.
    Write    cd ${SALWorkDir}/${subSystem}/python
    Comment    Start Sender.
    ${input}=    Write    python ${subSystem}_Event_${component}.py 
    ${output}=    Read Until Prompt
    Log    ${output}
    Should Contain    ${output}   ERROR : Invalid or missing arguments : CommandObject priority

Start Logger
    [Tags]    functional
    Switch Connection    Logger
    Comment    Move to working directory.
    Write    cd ${SALWorkDir}/${subSystem}/python
    Comment    Start Logger.
    ${input}=    Write    python ${subSystem}_EventLogger_${component}.py
    ${output}=    Read Until    logger ready
    Log    ${output}
    Should Contain    ${output}    ${subSystem}_${component} logger ready

Start Sender
    [Tags]    functional
    Switch Connection    Sender
    Comment    Move to working directory.
    Write    cd ${SALWorkDir}/${subSystem}/python
    Comment    Start Sender.
    ${input}=    Write    python ${subSystem}_Event_${component}.py 208 240 130 10 164 88 178 250 78 163 31 27 147 194 179 110 39 27 133 121 113 121 207 183 157 125 200 143 153 77 82 17 185 140 150 133 231 230 44 138 102 132 218 218 90 29 83 169 159 56 80 158 176 239 173 102 62 55 66 139 204 212 61 165 243 28 78 27 220 208 181 63 88 72 226 131 87 34 0 72 87 168 182 130 211 113 221 16 181 45 173 54 77 234 49 80 125 177 18 27 187 130 254 115 17 226 232 21 142 253 56 14 121 252 119 177 74 199 38 197 46 59 107 166 59 160 8 198 71 202 53 156 19 242 215 14 49 97 2 93 229 79 171 179 16 253 68 3 126 26 155 4 7 152 85 110 102 100 71 20 28 180 72 86 49 182 212 79 29 0 222 239 38 112 19 89 127 165 164 229 150 149 62 167 58 188 5 245 247 109 151 239 244 130 61 115 103 251 8 34 82 235 210 102 48 78 67 235 157 226 97 225 197 89 111 152 69 57 243 234 225 147 198 222 224 225 185 29 226 96 64 207 252 66 49 129 44 202 197 154 173 143 114 105 101 219 53 92 249 231 172 96 58 62 39 154 164 213 53 57 167 142 101 85 247 19 33 235 233 26 27 179 130 231 66 68 4 66 212 101 78 79 110 206 132 45 85 19 171 244 204 221 159 26 92 9 64 118 18 252 136 129 13 3 202 96 23 205 144 31 243 207 30 170 245 255 255 1 227 111 57 124 236 137 181 249 193 159 20 210 248 51 251 8 37 194 54 137 42 208 118 164 149 220 117 208 111 240 141 177 135 199 189 220 120 179 215 157 168 173 194 169 78 192 131 181 71 142 70 184 216 220 94 105 240 24 219 9 228 224 7 220 92 186 99 227 187 126 53 182 46 180 230 110 231 174 120 56 8 17 54 75 104 63 166 16 66 105 249 54 204 50 68 20 107 52 255 117 202 90 190 197 66 187 120 132 116 3 174 87 31 117 36 174 47 62 147 63 171 34 241 197 97 121 148 88 238 134 228 196 154 24 43 136 104 95 67 182 70 75 151 200 252 191 110 173 50 250 167 183 146 190 244 217 229 114 207 23 59 77 132 24 138 224 252 219 154 170 147 142 212 34 61 99 66 207 129 58 165 69 86 14 82 122 11 102 115 210 206 142 163 31 72 16 53 80 234 129 45 39 215 122 114 71 199 84 123 242 125 104 166 49 229 50 167 59 45 200 224 212 95 237 123 178 185 251 151 99 133 100 181 244 119 176 245 142 43 66 231 208 58 186 77 250 158 149 157 162 59 213 3 30 76 176 45 182 50 7 80 188 162 231 213 149 38 123 108 115 91 1 14 13 216 3 58 14 171 248 5 196 22 238 74 185 77 133 126 51 18 137 50 30 115 43 247 194 185 43 182 205 198 183 43 206 108 86 174 105 85 173 47 115 19 133 27 131 155 23 245 73 211 242 187 13 170 81 195 201 11 25 101 217 103 164 185 228 12 20 221 188 10 73 211 239 155 38 159 121 186 189 186 74 50 249 77 35 177 175 108 154 31 200 96 141 237 90 69 66 97 235 168 43 209 18 243 234 126 207 192 177 236 29 173 5 58 128 220 7 230 95 91 255 146 47 129 89 55 66 175 193 253 0 108 150 136 123 94 212 72 52 212 102 116 99 94 149 32 50 7 192 133 174 224 221 212 244 239 108 85 219 130 30 254 224 191 118 190 163 158 3 191 229 247 144 58 126 227 6 63 182 20 173 165 171 170 196 212 137 84 71 69 62 255 53 206 157 155 211 146 30 124 124 174 83 160 59 15 23 45 241 107 76 203 101 142 156 210 45 158 100 253 63 176 172 80 2 79 135 60 135 6 246 36 236 238 139 88 67 221 210 91 46 145 168 45 236 79 161 131 194 224 11 18 55 82 186 134 125 43 121 67 66 95 22 149 53 137 20 204 137 37 51 101 109 22 248 78 207 82 106 98 84 5 213 205 251 136 253 129 165 152 112 210 229 162 232 215 13 216 111 138 92 9 95 114 116 246 20 148 111 59 145 222 124 96 63 146 155 69 236 209 187 174 18 203 114 84 204 141 85 30 223 137 119 7 64 84 198 139 215 67 208 91 87 103 117 242 9 213 47 197 167 17 7 117 113 218 191 44 123 255 185 233 38 55 45 31 1 187 53 172 116 157 81 7 229 173 91 16 183 3 235 209 103 153 60 62 6 143 39 31 190 243 90 135 108 19 28 20 25 52 36 165 254 255 43 170 217 121 232 1722551459
    ${output}=    Read Until Prompt
    Log    ${output}
    Should Contain X Times    ${output}    === [putSample] tcs::logevent_InternalCommand writing a message containing :    1
    Should Contain    ${output}    revCode \ : LSST TEST REVCODE

Read Logger
    [Tags]    functional
    Switch Connection    Logger
    ${output}=    Read Until    ${component} received
    Log    ${output}
    Should Contain X Times    ${output}    Event ${subSystem} ${component} received     1
